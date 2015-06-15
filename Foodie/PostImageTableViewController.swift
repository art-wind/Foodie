//
//  PostImageTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class PostImageTableViewController: UITableViewController,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate{
    var isTaken:Bool = false
    let filterImageSegueID = "Filter Image"
    var sendTimes = 0
    
    var originalImage:UIImage?
//    var displayImage:UIImage?
    @IBOutlet var takenPhoto: UIImageView!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBAction func chooseFilterUnwindSegue (segue:UIStoryboardSegue){
        let srcVC = segue.sourceViewController as FilterViewController
        if let filteredImage = srcVC.filteredImage{
            takenPhoto.image = filteredImage
//            displayImage = filteredImage
            return
        }
        takenPhoto.image = srcVC.displayImage.image
//        displayImage = srcVC.displayImage.image
    }
    @IBAction func chooseTagCategoryUnwindSegue (segue:UIStoryboardSegue){
        //        let
        let srcVC = segue.sourceViewController as TagCategoryTableViewController
        let categoryArray = srcVC.category
        let selectedCat = srcVC.selectedCat
        var stringToPrint = ""
        var index = 0
        for i in selectedCat {
            if i == 1 {
                stringToPrint += "\(categoryArray[index]) "
            }
            index += 1
        }
        if stringToPrint != "" {
            tagLabel.text = stringToPrint
        }
        else{
            stringToPrint = "美食"
        }
        
    }
    
    
    
    override func viewDidLoad() {
        indicator.stopAnimating()
        takenPhoto.image = originalImage
    }
    @IBAction func cancelPostAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func postImageAction(sender: UIBarButtonItem) {
        indicator.startAnimating()
        let urlRequest = ImageUpload.createRequest(takenPhoto.image!)
        let content = contentTextView.text
        var tagText = tagLabel.text
        if tagText == ""{
            tagText = "美食"
        }
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue()
            ) {[weak self] (response, data, error) -> Void in
                if error == nil {
                    let urlString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    println("\(urlString)")
                    if let user = SharedVariable.currentUser() {
                        let aRequest = StatusManager.postStateRequest(user.id!, nickname: user.nickname!, pic_url: urlString, content: content, tag:tagText!,address: "Fudan")
                        NSURLConnection.sendAsynchronousRequest(aRequest, queue: NSOperationQueue(), completionHandler: {(response, data, error) -> Void in
                            if error == nil {
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    let alertView = UIAlertView(title: "状态发送完毕", message:nil, delegate: nil, cancelButtonTitle: "OK")
                                    
                                    alertView.show()
                                    self!.indicator.stopAnimating()
                                    self!.dismissViewControllerAnimated(true, completion: { () -> Void in
                                        
                                    })
                                })
                                
                                
                            }
                        })
                    }
                    
                    
                }
        }
    }
    @IBAction func takePicture(sender: UIButton) {
        var actionForm = UIActionSheet(title: imagePickerActionFormTitle, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library","Take a photo")
        actionForm.showInView(self.view)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if segue.identifier == filterImageSegueID{
            let filterVC = segue.destinationViewController as FilterViewController
            filterVC.originalImage = originalImage
        }
    }
    
    var imagePickerActionFormTitle = "从何处选取照片"
    @IBAction func takePhotoAsIcon(sender: UIButton) {
        
        
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        println("Press at index : \(buttonIndex)")
        if actionSheet.title == imagePickerActionFormTitle {
            if buttonIndex == 0 {
                
            }
            else{
                var imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
                    UIAlertAction(title: "Camera is not availble in your device!", style: UIAlertActionStyle.Cancel)
                        {
                            result in
                            println("A disabled phone Detected")
                    }
                }
                
                if buttonIndex == 1 {
                    
                }
                if buttonIndex == 2 {
                    imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                    imagePickerController.showsCameraControls = true
                    imagePickerController.allowsEditing = true
                }
                presentViewController(imagePickerController, animated: true, completion: { () -> Void in
                })
            }
            
        }
        
        
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        dismissViewControllerAnimated(true){}
        takenPhoto.image = image
        isTaken = true
    }
    
    //MARK: Scroll Delegate
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        contentTextView.resignFirstResponder()
    }

}

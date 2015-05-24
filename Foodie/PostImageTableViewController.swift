//
//  PostImageTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class PostImageTableViewController: UITableViewController,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate {
    var isTaken:Bool = false
    let filterImageSegueID = "Filter Image"
    @IBOutlet var takenPhoto: UIImageView!
    
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var locationLabel: UILabel!
    @IBAction func chooseFilterUnwindSegue (segue:UIStoryboardSegue){
//        let
        let srcVC = segue.sourceViewController as FilterViewController
        takenPhoto.image = srcVC.displayImage.image
    }
    @IBAction func postImageAction(sender: UIBarButtonItem) {
        let para = ["id":"ddd","name":"bill"]
        let urlRequest = ImageUpload.createRequest(UIImage(named: "cheesecake")!,parameters: para)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue()
            ) { (response, data, error) -> Void in
                if error == nil {
                    println("dasdsds")
                }
        }
    }
    @IBAction func takePicture(sender: UIButton) {
        //takenPhoto.image = UIImage(named:"monster")
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
            let defaultImage = UIImage(named: "monster")
            println("Filter image Segue")
            filterVC.originalImage = isTaken ? takenPhoto.image : defaultImage
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

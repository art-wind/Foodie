//
//  IconModifierViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class IconModifierViewController: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var modifiedIcon: UIImageView!
    let imagePickerActionFormTitle = "从哪里选取图片"
    let unwindSegueName = "Icon Modification Unwind Segue"
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = SharedVariable.currentUser() {
            CacheManager.setImageViewWithData(modifiedIcon, url: currentUser.icon!)
        }
        
        let submitBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("modifyIcon:"))
        self.navigationItem.rightBarButtonItem = submitBarItem

        // Do any additional setup after loading the view.
    }
    @IBAction func modifyIcon(sender:UIBarButtonItem){
        //HTTP Requst Goes here
//        let pictureService = ImageUpload.createRequest(modifiedIcon.image, parameters: [String : String])
        let alertString = ""
        let urlRequest = ImageUpload.createRequest(modifiedIcon.image!)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue()
            ) {[weak self] (response, data, error) -> Void in
                if error == nil {
                    let urlString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    if let user = SharedVariable.currentUser() {
                        let iconUploadRequest = UserManager.modifyRequest(user.id!, phoneNum: user.phoneNum!, pwd: user.password!, nickname: user.nickname!, iconURL: urlString)
                        NSURLConnection.sendAsynchronousRequest(iconUploadRequest, queue: NSOperationQueue(), completionHandler: { (response, data, error) -> Void in
                            user.icon = urlString
                            let alertView = UIAlertView(title: "上传成功", message: nil, delegate: nil, cancelButtonTitle: "关闭")
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                 alertView.show()
                                 self!.performSegueWithIdentifier(self!.unwindSegueName, sender: self)
                            })
                        })
                    }
                    
                    
                }
        }
        
    }
    @IBAction func selectIconAction(sender: UITapGestureRecognizer) {
        var actionForm = UIActionSheet(title: imagePickerActionFormTitle, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library","Take a photo")
        actionForm.showInView(self.view)
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
        modifiedIcon.image = image

    }

}

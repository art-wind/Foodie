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
        let submitBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("modifyIcon:"))
        self.navigationItem.rightBarButtonItem = submitBarItem

        // Do any additional setup after loading the view.
    }
    @IBAction func modifyIcon(sender:UIBarButtonItem){
        //HTTP Requst Goes here
        performSegueWithIdentifier(unwindSegueName, sender: self)
        
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

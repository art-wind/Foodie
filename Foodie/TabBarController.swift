//
//  TabBarController.swift
//  Foodie
//
//  Created by 许Bill on 15-6-10.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate {
    let postImageSegueName = "Post Image Segue"
    let actionSheetTitleForImage = "从何处选取图片"
    var takenPhoto:UIImage?
    //MARK: Center Button
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let timer = NSTimer(timeInterval: 2, target: self, selector: Selector("retrieveNoti:"), userInfo: nil, repeats: true)
//       NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    @IBAction func retrieveNoti(sender:NSTimer){
        println("INTO Retrieve")
    }
    override func viewWillAppear(animated: Bool) {
        addCenterButton("ad", image: UIImage(named: "CenterButton")!)
    }
    func addCenterButton(title:String,image:UIImage){
        
        let button = UIButton()
        button.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        button.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        button.setBackgroundImage(image, forState: .Normal)
        let heightDifferece = image.size.height - self.tabBar.frame.size.height
        if heightDifferece < 0{
            button.center = self.tabBar.center
        }
        else{
            var center = self.tabBar.center
            center.y = center.y - heightDifferece/2
            button.center = center
        }
        button.addTarget(self, action: Selector("action:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
    }
    
    //MARK: Action for Center Button
    //Action Sheet flow out
    @IBAction func action(sender:UIButton){
        var actionForm = UIActionSheet(title: actionSheetTitleForImage, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library","Take a photo")
        actionForm.showInView(self.view)
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        println("Press at index : \(buttonIndex)")
        if actionSheet.title == actionSheetTitleForImage {
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
                            return
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
        dismissViewControllerAnimated(true, completion: {[weak self] () -> Void in
            self!.takenPhoto = image
            self!.performSegueWithIdentifier(self!.postImageSegueName, sender: self)
        })
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == postImageSegueName {
            let postImageVC = (segue.destinationViewController as UINavigationController)
            let vc = postImageVC.childViewControllers[0] as PostImageTableViewController
            vc.originalImage = takenPhoto
//            vc = takenPhoto
        }
    }
    
   
    
}

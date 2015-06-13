//
//  ModificationTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class ModificationTableViewController: UITableViewController,UIActionSheetDelegate {
   
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var iconThumbnailImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem(title: "保存修改", style: .Plain, target: self, action: Selector("saveModified:"))
        navigationItem.rightBarButtonItem = saveButton
        
    }
    override func viewWillAppear(animated: Bool) {
        CacheManager.setImageViewWithData(iconThumbnailImageview, url: SharedVariable.currentUser()!.icon!)
        if let currentUser = SharedVariable.currentUser() {
            nicknameTextField.text = "\(currentUser.nickname!)"
        }
    }
    func saveModified(sender:UIBarButtonItem){
        // 上传修改的个人信息
        if let currentUser = SharedVariable.currentUser() {
            let currentNickname = nicknameTextField.text
            if currentNickname != currentUser.nickname! {
                let modifyRequest = UserManager.modifyRequest(currentUser.id!, phoneNum: currentUser.phoneNum!, pwd: currentUser.password!, nickname:currentNickname, iconURL: currentUser.icon!)
                NSURLConnection.sendAsynchronousRequest(modifyRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
                    currentUser.nickname = currentNickname
                    let alertView = UIAlertView(title: "昵称修改成功", message: nil, delegate: nil, cancelButtonTitle: "OK")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        alertView.show()
                        self!.navigationController?.popViewControllerAnimated(true)
                    })
                })
            }
            
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    @IBAction func unwindFromIconModification(segue:UIStoryboardSegue){
        let modiferVC = segue.sourceViewController as IconModifierViewController
        let image = modiferVC.modifiedIcon.image
        iconThumbnailImageview.image = image
        
    }
    @IBAction func logoutAction(sender: UIButton) {
       let actionSheet = UIActionSheet(title: "确认退出", delegate: self, cancelButtonTitle: "撤销", destructiveButtonTitle: "退出")
        actionSheet.showInView(tableView)
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println("\(buttonIndex)")
        if buttonIndex == 0 {
            dismissViewControllerAnimated(true, completion: { () -> Void in
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                appDelegate.currentUser = nil
                
            })
        }
    }
}

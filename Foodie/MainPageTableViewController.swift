//
//  MainPageTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController,UIAlertViewDelegate {
    //MARK: Reuse ID & Nibnames
    let cellReuseID = "DescriptionTableViewCell"
    let previousPhotoID = "Previous Photo TVC"
    let previousPhotoTVCNibName = "PreviousPhotoTableViewCell"
    let showConcernSegueID = "Show Friends"

    //MARK: Core targetUserId
    var targetUserID:Int?
    
    //MARK: Variables for displaying main page
    var socialInfo:SocialInfo?
    var statusList:[Status]?
    
    //Mark: Segue Variables
    var isPushed = false
    var isMyself:Bool = true
    var hasFollowed:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: cellReuseID, bundle: nil), forCellReuseIdentifier: cellReuseID)
        tableView.registerNib(UINib(nibName: previousPhotoTVCNibName, bundle: nil), forCellReuseIdentifier: previousPhotoID)
        if isPushed {
            self.navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("pop:"))
        }
       
        //HTTP Request for SocialInfo
//        if let currentUser = SharedVariable.currentUser(){
//            let socialInfoRequest = SocialInfoManager.personalPageRequest(currentUser.id!, target_id: targetUserID!)
//            NSURLConnection.sendAsynchronousRequest(socialInfoRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
//                self!.socialInfo = SocialInfo(xml: SWXMLHash.parse(data))
//                
//            })
//        }
        
        //HTTP Request for StatusList
        let statusRequest = StatusManager.statusByUserRequset(targetUserID!, pageNum: 0)
        NSURLConnection.sendAsynchronousRequest(statusRequest, queue: NSOperationQueue()) { [weak self](response, data, error) -> Void in
            self!.statusList = StatusManager.getStatusListFromData(data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let tableView = self!.tableView
                tableView.reloadData()
            })
        }
        
    }
    func pop(sender:UIBarButtonItem){
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            // 个人的头像、按钮等
            if let tmpSocialInfo = self.socialInfo {
                return 1
            }
            return 0
            
        }
        else{
            // 个人的拍摄历史
            if let list = statusList{
                return list.count
            }
            return 3
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        if section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionTableViewCell", forIndexPath: indexPath) as DescriptionTableViewCell
            cell.concernButton.addTarget(self, action: Selector("showConcernList:"), forControlEvents:UIControlEvents.TouchUpInside)
            cell.fansNumberLabel.text = "\(socialInfo?.fansNum!)"
            cell.concernNumberLabel.text = "\(socialInfo?.followNum!)"
            
            if isMyself {
                cell.messageNotifiactionButton.addTarget(self, action: Selector("showMessageNotificationList:"), forControlEvents:UIControlEvents.TouchUpInside)
                cell.messageNotificationNumberLabel.text = "\(socialInfo?.messageNum!)"
                
            }
            else{
                cell.messageNotifiactionButton.hidden = true
                cell.messageNotificationNumberLabel.hidden = true
                cell.triggerConcernButton.addTarget(self, action: Selector("triggerConcern:"), forControlEvents: UIControlEvents.TouchUpInside)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(previousPhotoID, forIndexPath: indexPath) as PreviousPhotoTableViewCell
            
            return cell
        }
        
    }
    func setButton(button:UIButton){
        if hasFollowed {
            button.setTitle("取消关注", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.blueColor()
        }
        else{
            button.setTitle("关注他", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.orangeColor()
        }
    }
    func triggerConcern(sender:UIButton){
        let currentUser = SharedVariable.currentUser()!
       
        //MARK: Trigger Concern and Cancel Concern Operations
//        if !hasFollowed{
//            let followRequest = UserManager.followRequest(currentUser.id!, followee_id: targetUserID!, type: 1)
//            NSURLConnection.sendAsynchronousRequest(followRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self!.hasFollowed = self!.hasFollowed
//                    self!.setButton(sender)
//                    let alertView = UIAlertView(title: "", message: "取消关注成功", delegate: self, cancelButtonTitle: "OK")
//                    alertView.show()
//                })
//            })
//            
//        }
//        else{
//            let cancelFollowRequest = UserManager.followRequest(currentUser.id!, followee_id: targetUserID!, type: 0)
//            NSURLConnection.sendAsynchronousRequest(cancelFollowRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self!.hasFollowed = self!.hasFollowed
//                    self!.setButton(sender)
//                    let alertView = UIAlertView(title: "", message: "关注成功", delegate: self, cancelButtonTitle: "OK")
//                    alertView.show()
//                })
//            })
//        }
        
    }
    func showMessageNotificationList(sender:AnyObject){
        performSegueWithIdentifier("Show Friends", sender: sender)
        let messageNotiTVC = MessageNotificationTableViewController()
        navigationController?.pushViewController(messageNotiTVC, animated: true)
    }
    
    
    
    
    func showConcernList(sender:AnyObject){
//        performSegueWithIdentifier("Show Friends", sender: sender)
        
        
        let  uiCVCFlowLayout = UICollectionViewFlowLayout()
        let frameWidth = self.view.frame.size.width
        uiCVCFlowLayout.itemSize = CGSize(width: 66, height: 95)
        uiCVCFlowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let friendsCVC = FriendsCollectionViewController(collectionViewLayout: uiCVCFlowLayout)
        navigationController?.pushViewController(friendsCVC, animated: true)
        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0 {
            
            return 120
        }
        else{
            return 200
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == showConcernSegueID{
            return true
        }
        else{
            return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showConcernSegueID{
            println("Into the friend List Segue")
        }
    }
    
    
    //MARK: Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        if section == 1{
            let detailStatusVC = VCGenerator.detailStatusVCGenerator()
            detailStatusVC.detailStatusImage = UIImage(named:"monster")
            detailStatusVC.userIconImage = UIImage(named:"monster")
            presentViewController(detailStatusVC, animated: true) { () -> Void in
                
            }
        }
    }

}

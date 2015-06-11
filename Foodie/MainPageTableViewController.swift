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
    var targetUserID:String?
    
    //MARK: Variables for displaying main page
    var socialInfo:SocialInfo?
    var statusList:[Status]?
    
    //Mark: Segue Variables
    var isRoot = false
    var firstTime : Bool = true
    
    //MARK: Global Variables
    var isMyself:Bool?
    var hasFollowed:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: cellReuseID, bundle: nil), forCellReuseIdentifier: cellReuseID)
        tableView.registerNib(UINib(nibName: previousPhotoTVCNibName, bundle: nil), forCellReuseIdentifier: previousPhotoID)
        if isRoot {
            self.navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("pop:"))
        }
        
//        onlineUpdate()
        
    }
    
    func pop(sender:UIBarButtonItem){
        if isRoot {
            dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
        else{
            navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        //refreshSocialInfo()
        
        onlineUpdate()
    }
    func refreshSocialInfo(){
        let currentUser = SharedVariable.currentUser()!
        let socialInfoRequest = SocialInfoManager.personalPageRequest(currentUser.id!, target_id: targetUserID!)
        NSURLConnection.sendAsynchronousRequest(socialInfoRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
            self!.socialInfo = SocialInfo.convertSocialInfo(SWXMLHash.parse(data))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let tableView = self!.tableView
                tableView.reloadData()
            })
        })
    }
    func onlineUpdate(){
        let currentUser = SharedVariable.currentUser()!
        if targetUserID == nil {
            isMyself = true
            targetUserID = currentUser.id
        }
        else{
            if isMyself == nil {
                isMyself =  (currentUser.id! == targetUserID!)
            }
        }
        
        refreshSocialInfo()
        
       
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
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        if section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionTableViewCell", forIndexPath: indexPath) as DescriptionTableViewCell
            cell.concernButton.addTarget(self, action: Selector("showConcernList:"), forControlEvents:UIControlEvents.TouchUpInside)
            cell.fansButton.addTarget(self, action: Selector("showFansList:"), forControlEvents:UIControlEvents.TouchUpInside)
            
            if let definedSocialInfo = socialInfo {
                
                CacheManager.setImageViewWithData(cell.iconImageView, url: definedSocialInfo.iconImage!)
                cell.nicknameLabel.text = "\(definedSocialInfo.nickname!)"
                cell.fansNumberLabel.text = "\(definedSocialInfo.fansNum!)"
                cell.concernNumberLabel.text = "\(definedSocialInfo.followNum!)"
                hasFollowed = definedSocialInfo.hasFollowed
                setButton(cell.triggerConcernButton)
                
                if let certainIsMyself = isMyself{
                    if certainIsMyself {
                        cell.messageNotifiactionButton.addTarget(self, action: Selector("showMessageNotificationList:"), forControlEvents:UIControlEvents.TouchUpInside)
                        cell.messageNotificationNumberLabel.text = "\(definedSocialInfo.messageNum!)"
                        cell.triggerConcernButton.hidden = true
                        cell.triggerConcernButton.enabled = false
                    }
                    else{
                        cell.messageNotifiactionButton.hidden = true
                        cell.messageNotificationNumberLabel.hidden = true
                        cell.triggerConcernButton.addTarget(self, action: Selector("triggerConcern:"), forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    
                }
            }
            
            return cell
        }
        else{
            let status = statusList![indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(previousPhotoID, forIndexPath: indexPath) as PreviousPhotoTableViewCell
            CacheManager.setImageViewWithData(cell.statusImageView, url: status.picture!)
            cell.statusLabel.text = "\(status.content!)"
            return cell
        }
        
    }
    func setButton(button:UIButton){
        if hasFollowed {
            button.setTitle("取消关注", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.orangeColor()
        }
        else{
            button.setTitle("关注他", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.blueColor()

        }
    }
    func triggerConcern(sender:UIButton){
        let currentUser = SharedVariable.currentUser()!
        println("Target: \(targetUserID!)")
        println("Current: \(currentUser.id!)")
        //MARK: Trigger Concern and Cancel Concern Operations
        if !hasFollowed{
            let followRequest = UserManager.followRequest(currentUser.id!, followee_id: targetUserID!, type: 1)
            NSURLConnection.sendAsynchronousRequest(followRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.hasFollowed = !self!.hasFollowed
                    self!.setButton(sender)
                    let alertView = UIAlertView(title: "", message: "关注成功", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                })
            })
            
        }
        else{
            let cancelFollowRequest = UserManager.followRequest(currentUser.id!, followee_id: targetUserID!, type: 0)
            NSURLConnection.sendAsynchronousRequest(cancelFollowRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (response, data, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.hasFollowed = !self!.hasFollowed
                    self!.setButton(sender)
                    let alertView = UIAlertView(title: "", message: "取消关注成功", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                })
            })
        }
        
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
//        friendsCVC.originalUser = User()
        friendsCVC.originalUserID = targetUserID
        friendsCVC.showFans = false
        navigationController?.pushViewController(friendsCVC, animated: true)
        
    }
    
    func showFansList(sender:AnyObject){
        //        performSegueWithIdentifier("Show Friends", sender: sender)
        
        
        let  uiCVCFlowLayout = UICollectionViewFlowLayout()
        let frameWidth = self.view.frame.size.width
        uiCVCFlowLayout.itemSize = CGSize(width: 66, height: 95)
        uiCVCFlowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let friendsCVC = FriendsCollectionViewController(collectionViewLayout: uiCVCFlowLayout)
        friendsCVC.originalUserID = targetUserID
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
            detailStatusVC.status = statusList![row]
            presentViewController(detailStatusVC, animated: true) { () -> Void in
                
            }
        }
    }
    
}

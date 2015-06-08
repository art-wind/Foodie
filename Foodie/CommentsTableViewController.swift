//
//  CommentsTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-6.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController,UITextFieldDelegate,UIScrollViewDelegate{
    let originalCellReuseID = "Original Post TVC"
    let originalCellNibName = "OriginalPostTableViewCell"
    
    let commentTVCReuseID = "Comment TVC"
    let commentTVCNibName = "CommentTableViewCell"
    
    let showConcernSegueID = "Show Friends"
    //    var is
//    var comments:[String] = ["饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人",
//        "饭菜看上去很诱人"]
    var commentsList:[Comment]?
    
    var targetStatus:Status?
    
    var inputBox = UITextField()
    let sendButton = UIButton()
    var toolBar:UIToolbar = UIToolbar()
    
    let boxIndent:CGFloat = 2
    let boxHeight:CGFloat = 35
    let buttonWidth:CGFloat = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: originalCellNibName, bundle: nil), forCellReuseIdentifier: originalCellReuseID)
        tableView.registerNib(UINib(nibName: commentTVCNibName, bundle: nil), forCellReuseIdentifier: commentTVCReuseID)
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if self.navigationController?.viewControllers.count == 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("pop:"))
        }
        
        
        
        //Input Box Handling
        var frameWidth = UIScreen.mainScreen().bounds.width
        var frameHeight = UIScreen.mainScreen().bounds.height
        if let navigationController = self.navigationController{
            let navigationBarheight = navigationController.navigationBar.frame.height
            frameHeight -= navigationBarheight + 20
        }
        inputBox.frame = CGRect(x: 8, y: boxIndent, width: frameWidth - buttonWidth - 25, height: boxHeight-2*boxIndent)
        inputBox.placeholder = "说说你的想法"
        inputBox.borderStyle = UITextBorderStyle.RoundedRect
        inputBox.addTarget(self, action: Selector("responseToTypeIn"), forControlEvents: UIControlEvents.TouchUpInside)
        inputBox.delegate = self
        
        sendButton.frame = CGRect(x: frameWidth - buttonWidth - 4, y:boxIndent, width: buttonWidth, height: boxHeight-2*boxIndent)
        sendButton.layer.cornerRadius = 10
        sendButton.layer.masksToBounds = true
        sendButton.setTitle("发送", forState: .Normal)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendButton.backgroundColor = UIColor(red: 110/256, green: 175/256, blue: 220/256, alpha: 1)
        sendButton.addTarget(self, action: Selector("commentAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: frameHeight - boxHeight , width: frameWidth, height: boxHeight))
        
        toolBar.addSubview(inputBox)
        toolBar.addSubview(sendButton)
        toolBar.hidden = true
        
        view.addSubview(toolBar)
        refreshAction()
        
    }
    @IBAction func refreshTheTable(sender:UIRefreshControl){
        refreshAction()
    }
    func refreshAction(){
        println("ID: \(targetStatus!.id!)")
        let getCommentsRequest = CommentManager.commentReadRequest(targetStatus!.id!, pageNum: 0)
        
        NSURLConnection.sendAsynchronousRequest(getCommentsRequest, queue: NSOperationQueue()) {[weak self] (response, data, error) -> Void in
            self!.commentsList = CommentManager.getCommentListFromData(data)
            dispatch_async( dispatch_get_main_queue(), { () -> Void in
                self!.tableView.reloadData()
            })
            
        }
    }

    func pop(sender:AnyObject){
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func commentAction(sender:UIButton){
        let text = inputBox.text
        
        if text == "" {
            
        }
        else{
            let currentUser = SharedVariable.currentUser()!
            let commentRequest = CommentManager.commentSendRequest(targetStatus!.id!, user_id: "\(currentUser.id!)", icon: currentUser.icon!, nickname: currentUser.nickname!, content: text)
            NSURLConnection.sendAsynchronousRequest(commentRequest, queue: NSOperationQueue(), completionHandler: { [weak self] (response, data, error) -> Void in
                dispatch_async( dispatch_get_main_queue(), { () -> Void in
                    self!.toolBar.hidden = true
                    self!.inputBox.resignFirstResponder()
                    let alertView = UIAlertView(title: "发布成功", message: nil, delegate: nil, cancelButtonTitle: "OK")
                    alertView.show()
                    self!.refreshAction()
                })
            })
        }
    }
    func responseToTypeIn (sender:UITextField){
    }
    
    // MARK: - Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let section = indexPath.section
        
        if section == 0 {
            
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let yAxis = cell.frame.origin.y
        var availableFrameHeight = UIScreen.mainScreen().bounds.width - boxHeight - 60
        toolBar.frame.origin.y = availableFrameHeight + yAxis
        toolBar.hidden = false
        
        inputBox.becomeFirstResponder()
        println(cell.bounds.origin.y)
        println(cell.frame.origin.y)
        tableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Top, animated: true)
        
        
//        tableView.scrollRectToVisible(cell.frame, animated: false)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 状态本身的 Cell Row = 1
        // 评论的个数 Cell Row = count
        if section == 1 {
            if let list = commentsList {
                return list.count
            }
            return 0
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        if section == 0 {
            // 输出源Photo的Cell
            let cell = tableView.dequeueReusableCellWithIdentifier(originalCellReuseID, forIndexPath: indexPath) as OriginalPostTableViewCell
            cell.nicknameLabel.text = targetStatus?.nickname!
            
            cell.contentLabel.text = targetStatus?.content!
            CacheManager.setImageViewWithData(cell.pictureImageView, url: targetStatus!.picture!)
            CacheManager.setImageViewWithData(cell.iconImageView , url: targetStatus!.user_icon!)
            return cell
        }
        else{
            // 输出评论的Cell
            let cell = tableView.dequeueReusableCellWithIdentifier(commentTVCReuseID, forIndexPath: indexPath) as CommentTableViewCell
            let comment = commentsList![indexPath.row]
            cell.contentLabel.text = comment.content
            cell.nicknameLabel.text = "\(comment.nickname!)"
            CacheManager.setImageViewWithData(cell.iconImageVIew, url:comment.icon!)
            DateLabelSetter.setLabel(cell.dateLabel, dateString: comment.date!)
            return cell
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let content =
        let section = indexPath.section
        if section == 0 {
            return 200
        }
        else{
            let content = commentsList![indexPath.row].content!
            return CommentTableViewCell.getHeight(content, width: tableView.frame.width)
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return indexPath.section == 1
    }
    
    //     Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //             Delete the row from the data source
            
            commentsList!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            //             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        toolBar.hidden = true
        inputBox.resignFirstResponder()
    }
    
}

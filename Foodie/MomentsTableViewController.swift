//
//  MomentsTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class MomentsTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    let cellReuseID = "Moment TVC"
    let cellNibName = "MomentTableViewCell"
    
    var statusList:[Status]?
    var selectedStatus:Status?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellReuseID)
        refreshControl?.addTarget(self, action: Selector("refreshTheTable:"), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        refreshAction()
    }
    @IBAction func refreshTheTable(sender:UIRefreshControl){
        refreshAction()
    }
    func refreshAction(){
        let user_id = SharedVariable.currentUser()!.id!
        let momentsRequest = StatusManager.momentsStatusRequest(user_id, pageNum: 0)
        NSURLConnection.sendAsynchronousRequest(momentsRequest, queue: NSOperationQueue()) {[weak self] (response, data, error) -> Void in
            self!.statusList = StatusManager.getStatusListFromData(data)
            dispatch_async( dispatch_get_main_queue(), { () -> Void in
                self!.tableView.reloadData()
                self!.refreshControl?.endRefreshing()
            })
           
        }
    }
    
    //MARK: TableView Datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if let list = statusList {
            return list.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    //Mark: Data's Header
    let headerViewHeight:CGFloat = 50
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let status = statusList![section]
        
        
        
        let frameWidth = tableView.frame.width
        
        let headerView = UITableViewHeaderFooterView(frame:CGRect(x: 0, y: 0, width: frameWidth, height: headerViewHeight))
        
        let iconOffset = CGPoint(x: 8, y: 8)
        let iconSize = CGSize(width: headerViewHeight-16, height: headerViewHeight-16)
        let iconImageView = UIImageView(frame: CGRect(origin: iconOffset, size: iconSize))
        CacheManager.setImageViewWithData(iconImageView, url: status.user_icon!)
        iconImageView.userInteractionEnabled = true
        iconImageView.layer.cornerRadius = (headerViewHeight-16)/2
        iconImageView.layer.masksToBounds = true
        iconImageView.tag = section
        CacheManager.setImageViewWithData(iconImageView, url: status.user_icon!)
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("iconTapGestureHandler:"))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        iconImageView.addGestureRecognizer(tapRecognizer)
        
        
        let nameLabelOffset = CGPoint(x: headerViewHeight, y: 8)
        let nameLabel = UILabel(frame: CGRect(origin: nameLabelOffset, size: CGSize(width: 50, height: headerViewHeight-16)))
        nameLabel.text = "\(status.nickname!)"
        
        
        
        //MARK:Header Data Info
        

        let dateString = "\(status.time!)"
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(16)
        timeLabel.textColor = UIColor.grayColor()
        DateLabelSetter.setLabel(timeLabel, dateString: dateString)
        
        let timeLabelSize = timeLabel.sizeThatFits(CGSize(width: 1000, height: 40))
        timeLabel.frame.size = timeLabelSize
        let floatHeight = (headerViewHeight - timeLabel.frame.size.height) / 2
        let timeLabelOffset = CGPoint(x: frameWidth - timeLabelSize.width - 8, y: floatHeight)
        timeLabel.frame.origin = timeLabelOffset
        
        headerView.addSubview(iconImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(timeLabel)
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as MomentTableViewCell
        
        let section = indexPath.section
        let status = statusList![section]
        
        
        
        cell.bringSubviewToFront(cell.pictureImageView)
        CacheManager.setImageViewWithData(cell.pictureImageView, url: status.picture!)
        
        //Button Setting
        cell.commentButton.tag = section
//        cell.commentButton.setTitle("\(status.commentNum!)", forState: UIControlState.Normal)
        cell.commentButton.addTarget(self, action: Selector("commentAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.admireButton.tag = section
//        cell.admireButton.setTitle("\(status.likeNum!)", forState: UIControlState.Normal)
        cell.admireButton.addTarget(self, action: Selector("admireAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.contentLabel.text = "\(status.content!)"
        cell.tagLabel.text = "\(status.tag!)"
        return cell
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    //MARK: Delegate Method for comment,admire and
    @IBAction func iconTapGestureHandler(sender:UIGestureRecognizer){
        println("in touch")
        let sendView = sender.view as UIImageView
        let sectionNumber = sendView.tag
        
        let status = statusList![sectionNumber]
        let mainPageVC = MainPageTableViewController()
        
        mainPageVC.isRoot = false
        mainPageVC.targetUserID = status.user_id
        self.navigationController?.pushViewController(mainPageVC, animated: true)
    }
    
    @IBAction func commentAction(sender: UIButton) {
    
        let tag = sender.tag
        let status = statusList![tag]
        
        let commentVC = CommentsTableViewController()
        commentVC.targetStatus = status
        
        let navVC = UINavigationController(rootViewController: commentVC)
        navVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    @IBAction func admireAction(sender:UIButton){
        let tag = sender.tag
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 330
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedStatus = statusList![indexPath.section]
        let detailStatusVC = VCGenerator.detailStatusVCGenerator()
        detailStatusVC.status = selectedStatus
        presentViewController(detailStatusVC, animated: true) { () -> Void in
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Make Comment"
        {
            let commentVC = segue.destinationViewController as CommentsTableViewController
            commentVC.targetStatus = selectedStatus
        }
    }
    
    
}

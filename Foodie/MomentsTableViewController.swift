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
    let pictureArr = ["pizza","sushi","strawberries"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    let headerViewHeight:CGFloat = 50
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frameWidth = tableView.frame.width
        
        let headerView = UITableViewHeaderFooterView(frame:CGRect(x: 0, y: 0, width: frameWidth, height: headerViewHeight))
        
        let iconOffset = CGPoint(x: 8, y: 8)
        let iconSize = CGSize(width: headerViewHeight-16, height: headerViewHeight-16)
        let imageView = UIImageView(frame: CGRect(origin: iconOffset, size: iconSize))
        imageView.image = UIImage(named: "HENRY")
        imageView.userInteractionEnabled = true
        imageView.layer.cornerRadius = (headerViewHeight-16)/2
        imageView.layer.masksToBounds = true
        imageView.tag = section
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("iconTapGestureHandler:"))
        //        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        imageView.addGestureRecognizer(tapRecognizer)
        
        
        let nameLabelOffset = CGPoint(x: headerViewHeight, y: 8)
        let nameLabel = UILabel(frame: CGRect(origin: nameLabelOffset, size: CGSize(width: 50, height: headerViewHeight-16)))
        nameLabel.text = "Henry"
        
        let dateString = "3/21"
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(16)
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.text = dateString
        
        let timeLabelSize = timeLabel.sizeThatFits(CGSize(width: 1000, height: 40))
        timeLabel.frame.size = timeLabelSize
        let floatHeight = (headerViewHeight - timeLabel.frame.size.height) / 2
        let timeLabelOffset = CGPoint(x: frameWidth - timeLabelSize.width - 8, y: floatHeight)
        timeLabel.frame.origin = timeLabelOffset
        
        headerView.addSubview(imageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(timeLabel)
        return headerView
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @IBAction func iconTapGestureHandler(sender:UIGestureRecognizer){
        println("in touch")
        let sendView = sender.view as UIImageView
        let sectionNumber = sendView.tag
        // Set User[sectionNumber]
        println(sectionNumber)
        let mainPageVC = MainPageTableViewController()
        mainPageVC.isMyself = false
        mainPageVC.isPushed = false
        self.navigationController?.pushViewController(mainPageVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as MomentTableViewCell
        
        
        
        cell.bringSubviewToFront(cell.pictureImageView)
        cell.pictureImageView.image = UIImage(named: pictureArr[indexPath.section])
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleTap:"))
        doubleTapRecognizer.numberOfTapsRequired = 2
        cell.pictureImageView.addGestureRecognizer(doubleTapRecognizer)
        
        //Button Setting
        cell.commentButton.tag = indexPath.section
        cell.commentButton.setTitle("12", forState: UIControlState.Normal)
        cell.commentButton.addTarget(self, action: Selector("commentAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.admireButton.tag = indexPath.section
        cell.admireButton.setTitle("1", forState: UIControlState.Normal)
        cell.admireButton.addTarget(self, action: Selector("admireAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //
        //        cell.iconImageView.image = UIImage(named:"monster")
        //        cell.messageTextView.text = "What a nice seaboat!"
        
        // Configure the cell...
        
        return cell
    }
    @IBAction func commentAction(sender: UIButton) {
        let tag = sender.tag
        
        let commentVC = CommentsTableViewController()
        
        //commentVC.targetID = "\(tag)"
        let navVC = UINavigationController(rootViewController: commentVC)
        navVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        //        commentVC.navigationItem = ""
        //        UINavigationController()
        //        pushViewController(commentVC, animated: true)
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    @IBAction func admireAction(sender:UIButton){
        let tag = sender.tag
        sender.setImage(UIImage(named: "monster"), forState: UIControlState.Highlighted)
    }
    @IBAction func doubleTap(sender:UITapGestureRecognizer){
        println("DOuble")
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        performSegueWithIdentifier("Make Comment", sender: self)
        println("sdd")
    }
    
    
}

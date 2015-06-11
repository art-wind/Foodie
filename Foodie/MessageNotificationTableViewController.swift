//
//  MessageNotificationTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class MessageNotificationTableViewController: UITableViewController {
    let messageNotificationTVCNibname = "MessageNotificationTableViewCell"
    let messageNotificationTVCID = "Message Notification Cell"
    
    var messages:[Message] = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(MessageNotificationTableViewCell.self, forCellReuseIdentifier: messageNotificationTVCID)
        let cellNib = UINib(nibName: messageNotificationTVCNibname, bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: messageNotificationTVCID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageNotificationTVCID, forIndexPath: indexPath) as MessageNotificationTableViewCell
        let message = messages[indexPath.row]
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
//        cell.pictureImageView.image = UIImage(
//        cell.messageLabel.text = ""
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    //MARK: Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let message = messages[indexPath.row]
        if message.type == 0 {
//            Push a mainPage
            let mainPageVC = MainPageTableViewController()
            mainPageVC.isMyself = false
            mainPageVC.isRoot = false
            self.navigationController?.pushViewController(mainPageVC, animated: true)
        }
        else{
//            Push a detailStatus
//            let detailStatusVC = VCGenerator.detailStatusVCGenerator()
//            detailStatusVC.statusID = message.targetId
//            presentViewController(detailStatusVC, animated: true, completion: { () -> Void in
//                
//            })
        }
    }

}

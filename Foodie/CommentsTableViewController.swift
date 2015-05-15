//
//  CommentsTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-6.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController,UITextFieldDelegate {
    let originalCellReuseID = "Original Post TVC"
    let originalCellNibName = "OriginalPostTableViewCell"
    
    let commentTVCReuseID = "Comment TVC"
    let commentTVCNibName = "CommentTableViewCell"
    
    let showConcernSegueID = "Show Friends"
//    var is
    var comments:[String] = ["CommentTableViewCell",
                            "CommentTableViewCellCommentTableViewCellCommentTableViewCell",
                            "CommentTableViewCellCommentTableViewCellCommentTableViewCellCommentTableViewCellCommentTableViewCell"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: commentTVCReuseID)
        tableView.registerNib(UINib(nibName: originalCellNibName, bundle: nil), forCellReuseIdentifier: originalCellReuseID)
        tableView.registerNib(UINib(nibName: commentTVCNibName, bundle: nil), forCellReuseIdentifier: commentTVCReuseID)
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if self.navigationController?.viewControllers.count == 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("pop:"))
        }
        
        self.tabBarItem = nil
        let inputBox = UITextField()
        inputBox.placeholder = "说说你的想法吧~"
        inputBox.frame = CGRect(x: 0, y: 600, width: 300, height: 30)
        inputBox.borderStyle = UITextBorderStyle.RoundedRect
        inputBox.addTarget(self, action: Selector("responseToTypeIn"), forControlEvents: UIControlEvents.TouchUpInside)
        inputBox.delegate = self
        
        let sendButton = UIButton()
        sendButton.titleLabel?.text = "发送"
        sendButton.titleLabel?.textColor = UIColor.whiteColor()
        sendButton.backgroundColor = UIColor.blueColor()
        sendButton.frame = CGRect(x: 310, y: 600, width: 50, height: 30)

        view.window?.addSubview(inputBox)
        view.window?.addSubview(sendButton)
        view.setNeedsDisplay()
    }
    func pop(sender:AnyObject){
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    func responseToTypeIn (sender:UITextField){
        resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0{
            // 状态本身的cell
            
        }
        else{
            // 评论的个数
            return comments.count
        }
        return 1
    }

//    table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        if section == 0 {
            // 输出源Photo的Cell
            let cell = tableView.dequeueReusableCellWithIdentifier(originalCellReuseID, forIndexPath: indexPath) as OriginalPostTableViewCell
            return cell
        }
        else{
            // 输出评论的Cell
            let cell = tableView.dequeueReusableCellWithIdentifier(commentTVCReuseID, forIndexPath: indexPath) as CommentTableViewCell
            cell.contentTextView.text = comments[indexPath.row]
            return cell
        }
        // Configure the cell...

        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : CommentTableViewCell.getHeight(comments[indexPath.row], width: tableView.frame.width)
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
            
            comments.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
//             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

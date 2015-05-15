//
//  MainPageTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    //MARK: Reuse ID & Nibnames
    let cellReuseID = "DescriptionTableViewCell"
    let previousPhotoID = "Previous Photo TVC"
    let previousPhotoTVCNibName = "PreviousPhotoTableViewCell"
    let showConcernSegueID = "Show Friends"

    //MARK: Critical properties for content
    /*
    var userOfMainPage:User?
    var statusOfUser:[Status]?
    var fans:[User]?
    var followees:[User]?
    var messages:[Message]?
    */
    
    //MARK: Navigation Item
    var isPushed = false
    var isMyself:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: cellReuseID, bundle: nil), forCellReuseIdentifier: cellReuseID)
        tableView.registerNib(UINib(nibName: previousPhotoTVCNibName, bundle: nil), forCellReuseIdentifier: previousPhotoID)
        if isPushed {
            self.navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("pop:"))
        }
    }
    func pop(sender:UIBarButtonItem){
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0{
            
            // 个人的头像、按钮等
            return 1
        }
        else{
            // 个人的拍摄历史
            return 3
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        if section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionTableViewCell", forIndexPath: indexPath) as DescriptionTableViewCell
            cell.concernButton.addTarget(self, action: Selector("showConcernList:"), forControlEvents:UIControlEvents.TouchUpInside)
            
            if isMyself {
                cell.messageNotifiactionButton.addTarget(self, action: Selector("showMessageNotificationList:"), forControlEvents:UIControlEvents.TouchUpInside)
            }
            else{
                cell.messageNotifiactionButton = nil
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(previousPhotoID, forIndexPath: indexPath) as PreviousPhotoTableViewCell
            
            return cell
        }
        // Configure the cell...
        
    }
    
    func showMessageNotificationList(sender:AnyObject){
        //        performSegueWithIdentifier("Show Friends", sender: sender)
        let messageNotiTVC = MessageNotificationTableViewController()
        navigationController?.pushViewController(messageNotiTVC, animated: true)
    }
    
    
    
    
    func showConcernList(sender:AnyObject){
//        performSegueWithIdentifier("Show Friends", sender: sender)
        
        
        let  uiCVCFlowLayout = UICollectionViewFlowLayout()
        //self.view.frame.size
        let frameWidth = self.view.frame.size.width
        uiCVCFlowLayout.itemSize = CGSize(width: frameWidth/4, height: frameWidth/4+50)
        
        uiCVCFlowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let friendsCVC = FriendsCollectionViewController(collectionViewLayout: uiCVCFlowLayout)
        navigationController?.pushViewController(friendsCVC, animated: true)
        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0 {
            
            return 140
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
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

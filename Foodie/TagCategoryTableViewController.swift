//
//  TagCategoryTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-6-11.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class TagCategoryTableViewController: UITableViewController {
    let cellReuseID = "Category Cell"
    let category = ["日料","点心","西餐","火锅","早茶"]
    let unwindSegueName = "Choose Tag Unwind Segue"
    var selectedCat:[Int] = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("submit:"))
        clearsSelectionOnViewWillAppear = false
        for _ in category {
            selectedCat.append(0)
        }
    }
    @IBAction func submit(sender:UIBarButtonItem){
        performSegueWithIdentifier(unwindSegueName, sender: self)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return category.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = category[row]
        cell.detailTextLabel?.text = category[row]
        
        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let index = selectedCat[row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if index == 0 {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedCat[row] = 1
        }
        else{
            cell?.accessoryType = UITableViewCellAccessoryType.None
            selectedCat[row] = 0
        }
    }

}

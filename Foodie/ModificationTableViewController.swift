//
//  ModificationTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class ModificationTableViewController: UITableViewController {
   
    @IBOutlet var iconThumbnailImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem(title: "保存修改", style: .Plain, target: self, action: Selector("saveModified:"))
        navigationItem.rightBarButtonItem = saveButton
        
    }
    override func viewWillAppear(animated: Bool) {
        CacheManager.setImageViewWithData(iconThumbnailImageview, url: SharedVariable.currentUser()!.icon!)
    }
    func saveModified(sender:UIBarButtonItem){
        // 上传修改的个人信息
        
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
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
}

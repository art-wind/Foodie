//
//  SearchResultsCollectionViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit



class SearchResultsCollectionViewController: UICollectionViewController {
    let reuseIdentifier = "Cell"
    var isPicture:Bool = true
    var searchKeyword = "Search"
    
    
    let pictureThumbnailCVCNibname = "PictureThumbnailCollectionViewCell"
    let pictureThumbnailCVCID = "Picture Thumbnail CVC"
    
    let userIconCVCNibName = "UserIconCollectionViewCell"
    let userIconCVCID = "User Icon CVC"
    var statusList:[Status]?
    var userList:[User]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(PictureThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: pictureThumbnailCVCID)
        self.collectionView!.registerNib(UINib(nibName: pictureThumbnailCVCNibname, bundle: nil), forCellWithReuseIdentifier: pictureThumbnailCVCID)
        
        self.collectionView!.registerClass(UserIconCollectionViewCell.self, forCellWithReuseIdentifier: userIconCVCID)
        self.collectionView!.registerNib(UINib(nibName: userIconCVCNibName, bundle: nil), forCellWithReuseIdentifier: userIconCVCID)
        
        
        let noti = NSNotificationCenter.defaultCenter()
        noti.addObserver(self, selector: Selector("refreshData:"), name: "startFetch", object: nil)

        // Do any additional setup after loading the view.
    }
    func refreshData (notification:NSNotification){
        let mapping = notification.userInfo as [String:String]
        let keyword = mapping["key"]!
        let type = mapping["type"]!
        isPicture = (type != "friend")
        let choice = isPicture ? 0 : 1
        let request = SearchManager.searchRequest(keyword, choice: choice, pageNum: 0)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), {[weak self] (response, data, error) -> Void in
            if self!.isPicture {
                self!.statusList = StatusManager.getStatusListFromData(data)
                if self!.statusList?.count == 0 {
                   self!.alertViewShown("无匹配结果", message: "无对应的图片")
                   return
                }
            }
            else{
                self!.userList = UserManager.getUserListFromData(data)
                if self!.userList?.count == 0 {
                    self!.alertViewShown("无匹配结果", message: "无对应的用户")
                    return
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let collectionView = self!.collectionView {
                     collectionView.reloadData()
                }
               
            })
        })
        
    }
    func alertViewShown(title:String,message:String){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Cancel")
            alertView.show()
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if isPicture {
            if let list = statusList {
                return list.count
            }
        }
        else{
            if let list = userList {
                return list.count
            }
        }
        return 0
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if isPicture {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(pictureThumbnailCVCID, forIndexPath: indexPath) as PictureThumbnailCollectionViewCell
            // Configure the cell
            cell.pictureThumbnailImageView.image = UIImage(named: "cheesecake")
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(userIconCVCID, forIndexPath: indexPath) as UserIconCollectionViewCell
            cell.iconImageView.image = UIImage(named: "HENRY")
            cell.nameLabel.text = "Monster"
            // Configure the cell
            //cell.frame.size = CGSize(width: view.frame.size.width/4,height: view.frame.size.width/4)
            return cell
        }
        
    }

    
    // MARK: Height&Width 
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let detailStatusVC = DetailStatusViewController()
//        self.navigationController?.pushViewController(detailStatusVC, animated: true)
//        presentViewController(detailStatusVC, animated: true) { () -> Void in
//            println("YESSSS")
//        }
        if isPicture{
            let detailStatusVC = VCGenerator.detailStatusVCGenerator()
//            detailStatusVC.userIconImage = UIImage(named: "HENRY")
//            detailStatusVC.detailStatusImage = UIImage(named: "cheesecake")
            presentViewController(detailStatusVC, animated: true) { () -> Void in
                
            }
        }
        else{
            let mainVC = MainPageTableViewController()
            mainVC.isPushed = true
//            mainVC.
            presentViewController(UINavigationController(rootViewController: mainVC), animated: true, completion: { () -> Void in
                
            })
//            self.navigationController?.pushViewController(mainVC, animated: true)
        }
        
    }
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

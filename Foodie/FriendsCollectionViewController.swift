//
//  FriendsCollectionViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit



class FriendsCollectionViewController: UICollectionViewController {
    let userIconReuseID = "User Icon CVC"
    let userIconNibName = "UserIconCollectionViewCell"
    
    var originalUserID:String?
    // True for Showing fans,
    // Otherwise show followees
    var showFans:Bool = true
    var userList:[User]?
    var nicknameTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
      
        // Register cell classes
        
        self.collectionView!.registerClass(UserIconCollectionViewCell.self, forCellWithReuseIdentifier: userIconReuseID)
        self.collectionView!.registerNib(UINib(nibName: userIconNibName, bundle: nil), forCellWithReuseIdentifier: userIconReuseID)
        
        if showFans {
//            navigationController?.title = "\(nicknameTitle!) 的粉丝"
            let showFansRequest = UserManager.fanListRequest(originalUserID!, pageNum: 0)
            NSURLConnection.sendAsynchronousRequest(showFansRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (repsonse, data, error) -> Void in
                self!.userList = UserManager.getUserListFromData(data)
                if let collectionView = self!.collectionView{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //
                        collectionView.reloadData()
                    })
                }
                
            })
        }
        else{
            
//            navigationController?.title = "\(nicknameTitle!)关注的"
            let showFollowersRequest = UserManager.followeesListRequest(originalUserID!, pageNum: 0)
            NSURLConnection.sendAsynchronousRequest(showFollowersRequest, queue: NSOperationQueue(), completionHandler: {[weak self] (repsonse, data, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.userList = UserManager.getUserListFromData(data)
                    if let collectionView = self!.collectionView{
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //
                            collectionView.reloadData()
                        })
                    }
                })
            })

        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if let list = userList{
            return list.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(userIconReuseID, forIndexPath: indexPath) as UserIconCollectionViewCell
        let row = indexPath.row
        let user = userList![row]
        
        cell.nameLabel.text = user.nickname!
        CacheManager.setImageViewWithData(cell.iconImageView, url: user.icon!)
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mainPageTVC = MainPageTableViewController()
        let user = userList![indexPath.row]
        mainPageTVC.targetUserID = user.id!
        mainPageTVC.isPushed = true
        navigationController?.pushViewController(mainPageTVC, animated: true)
    }
    
}

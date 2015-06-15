 //
//  SquareCollectionViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-4-30.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit



class SquareCollectionViewController: UICollectionViewController{
    let nameArray = ["cheesecake","strawberries","sushi","sanwenyu","pizza"]
    let squareCVCReuseID = "Square CVC"
    let squareNibname = "SquareCollectionViewCell"
    let detailSegueName = "Present Detail"
    var statusList = [Status]()
    let refreshControl = UIRefreshControl()
    let moreSquareID = "More Square ID"
    let moreSquareNibname = "MoreSquareCollectionViewCell"
    
    
    var isEnd = false
    var pageNum = 0
    //MARK: View load and will appear
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(SquareCollectionViewCell.self, forCellWithReuseIdentifier: squareCVCReuseID)
        self.collectionView?.registerNib(UINib(nibName: squareNibname, bundle: nil), forCellWithReuseIdentifier: squareCVCReuseID)
       
        
        
        self.collectionView!.registerClass(MoreSquareCollectionViewCell.self, forCellWithReuseIdentifier: moreSquareID)
        self.collectionView?.registerNib(UINib(nibName: moreSquareNibname, bundle: nil), forCellWithReuseIdentifier: moreSquareID)
        //Refresh Control Involved 
        
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: Selector("refreshControlAction:"), forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshControl)
        getStatusAndReload()
    }
    override func viewDidAppear(animated: Bool) {
    }
    @IBAction func refreshControlAction(sender:UIRefreshControl){
        refreshControl.beginRefreshing()
        getStatusAndReload()
    }
    @IBAction func refreshAction(sender: UIBarButtonItem) {
        refreshControl.beginRefreshing()
        getStatusAndReload()
    }
    func retrieveMoreStatus(){
        
        if let user = SharedVariable.currentUser(){
            if !isEnd {
                
                pageNum += 1
                let request = StatusManager.squareStatusRequest(user.id!, pageNum: pageNum)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{[weak self](response, data, error) -> Void in
                    
                    let newStatusList = StatusManager.getStatusListFromData(data)
                    for s in newStatusList {
                        self!.statusList.append(s)
                    }
                    
                    if let collectionView = self!.collectionView {
                        dispatch_async(dispatch_get_main_queue(), {() -> Void in
                            collectionView.reloadData()
                            self!.refreshControl.endRefreshing()
                        })
                    }
                    
                })
            }
            else{
                
                let alertView = UIAlertView(title: "已经看完了", message: "再刷新一下吧！", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
            
        }
    }
    func getStatusAndReload (){
        if let user = SharedVariable.currentUser(){
            pageNum = 0
            let request = StatusManager.squareStatusRequest(user.id!, pageNum: pageNum)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{[weak self](response, data, error) -> Void in
                
               
                self!.statusList = StatusManager.getStatusListFromData(data)
                
                if let collectionView = self!.collectionView {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        collectionView.reloadData()
                        self!.refreshControl.endRefreshing()
                    })
                }
                
            })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if statusList.count % 12 == 0 {
            isEnd = false
            return statusList.count + 1
        }
        else{
            isEnd = true
            return statusList.count 
        }
        
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        if row < statusList.count {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(squareCVCReuseID, forIndexPath: indexPath) as SquareCollectionViewCell
            let status = statusList[row]
            var pictureName = status.picture! as NSString
            pictureName = pictureName.substringToIndex(pictureName.length - 1)
            
            CacheManager.setImageViewWithData(cell.squareImage, url: pictureName)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(moreSquareID, forIndexPath: indexPath) as MoreSquareCollectionViewCell
            if isEnd {
                cell.moreImageView.image = UIImage(named: "Done")
            }
            else{
                 cell.moreImageView.image = UIImage(named: "More")
            }
           
            return cell
        }
        
    }
    //MARK: Delegate Method
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        if row < statusList.count {
            let detailStatusVC = VCGenerator.detailStatusVCGenerator()
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as SquareCollectionViewCell
            
            detailStatusVC.status = statusList[row]
            presentViewController(detailStatusVC, animated: true) { () -> Void in
                
            }
        }
        else{
            retrieveMoreStatus()
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == detailSegueName {
            let detailStatusVC = segue.destinationViewController as DetailStatusViewController
            
//            detailStatusVC.imageView.image = UIImage(named: "monster")
        }
    }
}

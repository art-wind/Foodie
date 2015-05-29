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
    
    //MARK: View load and will appear
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(SquareCollectionViewCell.self, forCellWithReuseIdentifier: squareCVCReuseID)
        self.collectionView?.registerNib(UINib(nibName: squareNibname, bundle: nil), forCellWithReuseIdentifier: squareCVCReuseID)
       
        //Refresh Control Involved 
        
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: Selector("refreshControl:"), forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshControl)
    }
    override func viewDidAppear(animated: Bool) {
    }
    @IBAction func refreshControl(sender:UIRefreshControl){
        refreshControl.beginRefreshing()
        getStatusAndReload()
    }
    @IBAction func refreshAction(sender: UIBarButtonItem) {
        getStatusAndReload()
    }
    func getStatusAndReload (){
        if let user = SharedVariable.currentUser(){
            println(user.id)
            
            
            let request = StatusManager.squareStatusRequest(user.id!, pageNum: 0)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{[weak self](response, data, error) -> Void in
                
                println("start")
                
                self!.statusList = StatusManager.getStatusListFromData(data)
                
                if let collectionView = self!.collectionView {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        collectionView.reloadData()
                        self!.refreshControl.endRefreshing()
                    })
                }
                
                println("Ending")
            })
        }
        
    }
    func reload(){
        println("sadsds")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(statusList.count)
        return statusList.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(squareCVCReuseID, forIndexPath: indexPath) as SquareCollectionViewCell
        let row = indexPath.row
        
        let status = statusList[row]
        var pictureName = status.picture! as NSString
        pictureName = pictureName.substringToIndex(pictureName.length - 1)
        
        let basicURL = NSURL(string: "http://115.29.138.163:8080/")
        let pictureURL = NSURL(string: pictureName, relativeToURL: basicURL)
        //Loading Image
        cell.squareImage.image = UIImage(named: "coke")
        
        CacheManager.setImageViewWithData(cell.squareImage, url: "http://115.29.138.163:8080/\(pictureName)")
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailStatusVC = VCGenerator.detailStatusVCGenerator()
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as SquareCollectionViewCell
        
        let row = indexPath.row
        detailStatusVC.status = statusList[row]
        detailStatusVC.detailStatusImage = cell.squareImage.image
        detailStatusVC.userIconImage = UIImage(named: "coke")
        presentViewController(detailStatusVC, animated: true) { () -> Void in
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == detailSegueName {
            let detailStatusVC = segue.destinationViewController as DetailStatusViewController
            
//            detailStatusVC.imageView.image = UIImage(named: "monster")
        }
    }
}

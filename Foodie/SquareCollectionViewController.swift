//
//  SquareCollectionViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-4-30.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit



class SquareCollectionViewController: UICollectionViewController {
    let nameArray = ["cheesecake","strawberries","sushi","sanwenyu","pizza"]
    let squareCVCReuseID = "Square CVC"
    let squareNibname = "SquareCollectionViewCell"
    let detailSegueName = "Present Detail"
    var statusList = [Status]()
    //MARK: View load and will appear
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(SquareCollectionViewCell.self, forCellWithReuseIdentifier: squareCVCReuseID)
        self.collectionView?.registerNib(UINib(nibName: squareNibname, bundle: nil), forCellWithReuseIdentifier: squareCVCReuseID)
       
    }
    override func viewDidAppear(animated: Bool) {
    }
    @IBAction func refreshAction(sender: UIBarButtonItem) {
        getStatusAndReload()
    }
    func getStatusAndReload (){
        if let user = SharedVariable.currentUser(){
            println(user.id)
            
            
            let request = StatusManager.squareStatusRequest(user.id!, pageNum: 0)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{(response, data, error) -> Void in
                
                println("start")
                
                self.statusList = StatusManager.getStatusListFromData(data)
                println("\(self.statusList.count)")
                if let collectionView = self.collectionView {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        collectionView.reloadData()
                    })
                }
                
                println("Ending")
            })
        }
        
    }
    func reload(){
//        self.collectionView?.reloadData()
        println("sadsds")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.squareImage.image = UIImage(named: "coke")
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            cell.squareImage.image = UIImage(data: NSData(contentsOfURL: pictureURL!)!)
//        })
        
        CacheManager.setImageViewWithData(cell.squareImage, url: "http://115.29.138.163:8080/\(pictureName)")
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailStatusVC = VCGenerator.detailStatusVCGenerator()
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as SquareCollectionViewCell
        
        let row = indexPath.row
        let image = UIImage(named: nameArray[row])
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

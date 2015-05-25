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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(SquareCollectionViewCell.self, forCellWithReuseIdentifier: squareCVCReuseID)
        self.collectionView?.registerNib(UINib(nibName: squareNibname, bundle: nil), forCellWithReuseIdentifier: squareCVCReuseID)
        // Do any additional setup after loading the view.
       
    }
    override func viewDidAppear(animated: Bool) {
         getStatusAndReload()
    }
    @IBAction func refreshAction(sender: UIBarButtonItem) {
        getStatusAndReload()
    }
    func getStatusAndReload (){
        if let user = SharedVariable.currentUser(){
            
            let request = StatusManager.squareStatusRequest(user.id!, pageNum: 0)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{[weak self] (response, data, error) -> Void in
                
                println("start")
                
                
                self!.statusList = StatusManager.getStatusListFromData(data)
                self!.collectionView?.reloadData()
                
            })
        }
        
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
        cell.squareImage.image = UIImage(data: NSData(contentsOfURL: pictureURL!)!)
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailStatusVC = VCGenerator.detailStatusVCGenerator()
        let row = indexPath.row
        let image = UIImage(named: nameArray[row])
        detailStatusVC.detailStatusImage = image
        detailStatusVC.userIconImage = UIImage(named: "HENRY")
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

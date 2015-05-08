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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(squareCVCReuseID, forIndexPath: indexPath) as SquareCollectionViewCell
        let row = indexPath.row
        let length = nameArray.count
        
        cell.squareImage.image = UIImage(named: nameArray[row%length])
        return cell
    }
}

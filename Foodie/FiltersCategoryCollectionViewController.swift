//
//  FiltersCategoryCollectionViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-2.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

import CoreImage

class FiltersCategoryCollectionViewController: UICollectionViewController {
    var imageVar:UIImage?
    
    //    let filter = CIFilter(name: kCICategorySharpen)
    let filterStrings = ["CISepiaTone","CIPhotoEffectChrome","CIPhotoEffectMono","CIPhotoEffectInstant"]
    
    let filtersCategoryCVCNibname = "FiltersCategoryCollectionViewCell"
    let filtersCategoryCVCID = "Filters Category CVC"
    var filterImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(FiltersCategoryCollectionViewCell.self, forCellWithReuseIdentifier: filtersCategoryCVCID)
        self.collectionView?.registerNib(UINib(nibName: filtersCategoryCVCNibname, bundle: nil), forCellWithReuseIdentifier: filtersCategoryCVCID)
        
        for filterName in filterStrings{
            
            let filter = CIFilter(name: filterName)
            let coreImage = CIImage(image: imageVar)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            let filterImage = UIImage(CIImage: filter.outputImage)
            filterImages.append(filterImage!)
        }
        
        println()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        println("Length : \(filterStrings.count)")
        return filterStrings.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(filtersCategoryCVCID, forIndexPath: indexPath) as FiltersCategoryCollectionViewCell
        cell.filterImageView.image = filterImages[indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let filteredImage = filterImages[indexPath.row]
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: "FilterChosen", object: self, userInfo: ["value":filterStrings[indexPath.row]])
        center.postNotification(notification)
    }
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

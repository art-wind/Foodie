//
//  FilterViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-9.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet var displayImage: UIImageView!
    var originalImage = UIImage(named: "monster")
    let embeddedSegueID = "Embed Filters Category"
    var originalSize:CGSize?
    var originalPoint:CGPoint?
    var filteredImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        let postBarItem = UIBarButtonItem(title: "选择", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("choiceMade:"))
        self.navigationItem.rightBarButtonItem = postBarItem
        originalSize = displayImage.bounds.size
        originalPoint = displayImage.frame.origin
//        println("ORI \()")
        
        displayImage.image = originalImage
//        displayImage.bounds.size = originalSize!
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: Selector("refreshImage:"), name: "FilterChosen", object: nil)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
        
    }
    
    func refreshImage (notification:NSNotification){
        let mapping = notification.userInfo as [String:String]
        println("\(displayImage.bounds.size)")
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        
        
        
        let filterName = mapping["value"]
        if filterName == "" {
            displayImage.image = originalImage
        }
        else{
            let filter = CIFilter(name: filterName)
            let coreImage = CIImage(image: originalImage)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            let filterImageData = filter.outputImage
            
            displayImage.image = UIImage(CIImage: filterImageData)
            
            let cgImage = context.createCGImage(filterImageData, fromRect: filterImageData.extent())
            filteredImage = UIImage(CGImage: cgImage)
        }
        
        
    }
    func choiceMade(sender:UIBarButtonItem){
        //返回前一页 并保存图片
        performSegueWithIdentifier("unwind", sender: self)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == embeddedSegueID{
            //embeddedSegueID
            let filtersCategoryVC = segue.destinationViewController as FiltersCategoryCollectionViewController
            println("thumbNail 1")
            filtersCategoryVC.imageVar = Thumbnail.thumbnailFromImage(originalImage!, scaledToFillSize: CGSize(width: 66, height: 66))
            println("thumbNail 2")
        }
        if segue.identifier == "unwind" {
            
        }
    }
    
}

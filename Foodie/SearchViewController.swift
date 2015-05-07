//
//  SearchViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let embedSegueID = "Embed Segue"
    var isPic = true
    @IBOutlet var segmentController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentController.addTarget(self, action: Selector("braodcast:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func braodcast(sender:UISegmentedControl){
        let center = NSNotificationCenter.defaultCenter()
        var map = [String:String]()
        isPic = !isPic
        if !isPic {
            map = ["string":"aa","type":"friend"]
            
        }
        else{
            map = ["string":"aa","type":"picture"]
        }
        let noti = NSNotification(name: "startFetch", object: self, userInfo: map)
        center.postNotification(noti)
        
//        performSegueWithIdentifier(embedSegueID, sender: sender)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == embedSegueID {
            let searchResultsVC = segue.destinationViewController as SearchResultsCollectionViewController
            searchResultsVC.isPicture = true
        }
        else{
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

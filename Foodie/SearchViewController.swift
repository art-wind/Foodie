//
//  SearchViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-6-1.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate{

    @IBOutlet var searchBar: UISearchBar!
    let embedSegueID = "Embed Segue"
    var isPic = true
    @IBOutlet var segmentController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentController.addTarget(self, action: Selector("braodcast:"), forControlEvents: UIControlEvents.ValueChanged)
        searchBar.delegate = self
//        searchBar.
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func braodcast(sender:UISegmentedControl){
        isPic = !isPic
        
        sendNotification()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        println("INNIIII")
        searchBar.resignFirstResponder()
        sendNotification()
    }
    func sendNotification(){
        let center = NSNotificationCenter.defaultCenter()
        let key = searchBar.text
        var map = [String:String]()
        if !isPic {
            map = ["key":key,"type":"friend"]
            
        }
        else{
            map = ["key":key,"type":"picture"]
        }
        let noti = NSNotification(name: "startFetch", object: self, userInfo: map)
        center.postNotification(noti)
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

//
//  DetailStatusViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-8.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class DetailStatusViewController: UIViewController {
    //Status to present
    var status:Status?
    var userIconImage:UIImage?
    var detailStatusImage:UIImage?
    var isAdmired = false
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var praiseButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var userIconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let iconImage = userIconImage{
            //                let iconURL = NSURL(string: definedStatus.author!)!
            //                let iconData = NSData(contentsOfURL: iconURL)!
            //                userIconImageView.image = UIImage(data:iconData)
            
            userIconImageView.image = userIconImage
            let width = userIconImageView.bounds.size.width
            userIconImageView.layer.cornerRadius = width/2
            userIconImageView.layer.masksToBounds = true
        }
//        if let detailImage = detailStatusImage{
//            imageView.image = detailImage
//            
//        }
        
        
        
        if let definedStatus = status {
            imageView.image = detailStatusImage!
            contentLabel.text = definedStatus.content
            CacheManager.setImageViewWithData(imageView, url: definedStatus.picture!)
            praiseButton.setTitle("\(definedStatus.likeNum!)", forState: UIControlState.Normal)
            commentButton.setTitle("\(definedStatus.commentNum!)", forState: UIControlState.Normal)
        }
    }
    
    
    //MARK: Actions of Users
    @IBAction func backAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func commentAction(sender: UIButton) {
        let commentVC = CommentsTableViewController()
        let navVC = UINavigationController(rootViewController: commentVC)
        navVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    @IBAction func admireAction(sender: UIButton) {
        var admireNumber =  (sender.titleLabel?.text?.toInt())!
        var image:UIImage?
        if isAdmired {
            admireNumber += 1
            image = UIImage(named: "Heart")
        }
        else{
            admireNumber -= 1
            image = UIImage(named: "Message")
        }
        isAdmired = !isAdmired
        
        sender.setImage(image, forState: UIControlState.Normal)
        sender.setTitle("\(admireNumber)", forState: UIControlState.Normal)
        
    }
    
    
    @IBAction func userIconTouched(sender: UITapGestureRecognizer) {
        let mainPageVC = MainPageTableViewController()
        mainPageVC.isMyself = false
        mainPageVC.isPushed = true
        
        
        //MARK: Segue For Main Page
        let navVC = UINavigationController(rootViewController: mainPageVC)
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    
    
    
    override init() {
        super.init()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}

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
    var isAdmired = false
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var praiseButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var userIconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let definedStatus = status {
            contentLabel.text = definedStatus.content
            
            let radius = imageView.frame.width / 2
            imageView.layer.cornerRadius = radius
            imageView.layer.masksToBounds = true
            
            CacheManager.setImageViewWithData(imageView, url: definedStatus.picture!)
            CacheManager.setImageViewWithData(userIconImageView, url: definedStatus.user_icon!)
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
        commentVC.targetStatus = status
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
        
        let targetID = status!.user_id!
        mainPageVC.targetUserID = targetID
        println(targetID)
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

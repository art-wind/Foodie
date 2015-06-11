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
    @IBOutlet var flagLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let definedStatus = status {
            contentLabel.text = definedStatus.content
            
            let radius = userIconImageView.frame.width / 2
            userIconImageView.layer.cornerRadius = radius
            userIconImageView.layer.masksToBounds = true
            
            CacheManager.setImageViewWithData(imageView, url: definedStatus.picture!)
            CacheManager.setImageViewWithData(userIconImageView, url: definedStatus.user_icon!)
            praiseButton.setTitle("\(definedStatus.likeNum!)", forState: UIControlState.Normal)
            commentButton.setTitle("\(definedStatus.commentNum!)", forState: UIControlState.Normal)
            flagLabel.text = "\(definedStatus.tag!)"
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
    
    
    
    @IBAction func userIconTouched(sender: UITapGestureRecognizer) {
        let mainPageVC = MainPageTableViewController()
        mainPageVC.isRoot = true
        
        let targetID = status!.user_id!
        mainPageVC.targetUserID = targetID
        println(targetID)
        //MARK: Segue For Main Page
        let navVC = UINavigationController(rootViewController: mainPageVC)
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    @IBAction func admireActionByDoubleTap(sender: UITapGestureRecognizer) {
        admireAction()
    }
    
    @IBAction func admireAction(sender: UIButton) {
        admireAction()
    }
    func admireAction(){
        let sender = praiseButton
        var admireNumber =  (sender.titleLabel?.text?.toInt())!
        var image:UIImage?
        if isAdmired {
            let alertView = UIAlertView(title: "重复", message: "你已点赞~浏览其他的图片吧~", delegate: nil, cancelButtonTitle: "ok")
            alertView.show()
            admireNumber -= 1
            image = UIImage(named: "Heart")
        }
        else{
            let request = StatusManager.admireStatusRequest(status!.id!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response, data, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alertView = UIAlertView(title: "成功", message: "点赞成功", delegate: nil, cancelButtonTitle: "ok")
                    alertView.show()
                })
            })
            
            admireNumber += 1
            image = UIImage(named: "RedHeart")
            sender.enabled = false
        }
        isAdmired = !isAdmired
        
        sender.setImage(image, forState: UIControlState.Normal)
        sender.setTitle("\(admireNumber)", forState: UIControlState.Normal)

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

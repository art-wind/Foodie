//
//  DetailStatusViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-8.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class DetailStatusViewController: UIViewController {

    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var praiseButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    
    @IBAction func touchededd(sender: UITapGestureRecognizer) {
        println("TAppped!!!")
        let mainPageVC = MainPageTableViewController()
        mainPageVC.isMyself = false
        mainPageVC.isPushed = true
        let navVC = UINavigationController(rootViewController: mainPageVC)
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    var userIconImage:UIImage?
    var detailStatusImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = detailStatusImage!
        if let iconImage = userIconImage{
            
            userIconImageView.image = userIconImage
            let width = userIconImageView.bounds.size.width
            userIconImageView.layer.cornerRadius = width/2
            userIconImageView.layer.masksToBounds = true
        }
    }
    
    
    
    @IBAction func backAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func commentAction(sender: UIButton) {
        let commentVC = CommentsTableViewController()
        let navVC = UINavigationController(rootViewController: commentVC)
        navVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//        commentVC.navigationItem = ""
//        UINavigationController()
//        pushViewController(commentVC, animated: true)
        presentViewController(navVC, animated: true) { () -> Void in
            
        }
    }
    @IBAction func checkMainPage(sender: UIButton) {
        let mainPageVC = MainPageTableViewController()
        mainPageVC.isMyself = false
        mainPageVC.isPushed = true
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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //imageView.image = UIImage(named: "monster")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

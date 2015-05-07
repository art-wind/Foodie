//
//  FilterViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-2.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit
// 滤镜
class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let postBarItem = UIBarButtonItem(title: "选择", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("choiceMade"))
        self.navigationItem.rightBarButtonItem = postBarItem
        // Do any additional setup after loading the view.
    }

    func choiceMade(sender:UIBarButtonItem){
        //返回前一页 并保存图片
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CommentTableViewCell.swift
//  Foodie
//
//  Created by 许Bill on 15-5-6.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell,UIActionSheetDelegate {

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var iconImageVIew: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        println("sadasd")
        // Initialization code
    }

    @IBAction func longPressGestureHandler(sender: UILongPressGestureRecognizer) {
        println("Long")
        let action = UIActionSheet(title: "What do you want to do", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "删除", otherButtonTitles: "取消","关闭")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func getHeight(commentString:String?,width:CGFloat)->CGFloat{
        if let str = commentString{
//            var textLabel:UILabel = UILabel()
            var textView : UITextView = UITextView()
            textView.text = commentString
            textView.font = UIFont.systemFontOfSize(14)
            return max(textView.sizeThatFits(CGSize(width: width - 90, height: 1000)).height+20,46)
        }
        return 10
    }
    
}

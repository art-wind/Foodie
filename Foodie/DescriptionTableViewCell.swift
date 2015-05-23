//
//  DescriptionTableViewCell.swift
//  Foodie
//
//  Created by 许Bill on 15-5-4.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet var concernButton: UIButton!
    @IBOutlet var passiveConcernButton: UIButton!
    @IBOutlet var messageNotifiactionButton: UIButton!
    @IBOutlet var concernNumberLabel: UILabel!
    @IBOutlet var fansNumberLabel: UILabel!
    @IBOutlet var messageNotificationNumberLabel: UILabel!
    @IBOutlet var triggerConcernButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        concernNumberLabel.text = "22"
        fansNumberLabel.text = "12"
        messageNotificationNumberLabel.text = "10"
        triggerConcernButton.layer.cornerRadius = 3
        triggerConcernButton.layer.masksToBounds = true
        triggerConcernButton.setTitle("关注他", forState: UIControlState.Normal)
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

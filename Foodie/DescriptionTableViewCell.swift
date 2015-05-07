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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

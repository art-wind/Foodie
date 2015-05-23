//
//  OriginalPostTableViewCell.swift
//  Foodie
//
//  Created by 许Bill on 15-5-6.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class OriginalPostTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pictureImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

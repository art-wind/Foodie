//
//  MomentTableViewCell.swift
//  Foodie
//
//  Created by 许Bill on 15-5-2.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class MomentTableViewCell: UITableViewCell {

    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var admireButton: UIButton!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureImageView.userInteractionEnabled = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

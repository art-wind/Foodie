//
//  FiltersCategoryCollectionViewCell.swift
//  Foodie
//
//  Created by 许Bill on 15-5-9.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class FiltersCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var filterImageView: UIImageView!
    @IBOutlet var filterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setSelect(){
        self.filterImageView.layer.borderColor = Constants.sharedColor.CGColor
        self.filterImageView.layer.borderWidth = 4
        self.filterNameLabel.textColor = Constants.sharedColor
    }
    func setDeselect(){
        self.filterImageView.layer.borderWidth = 0
        self.filterNameLabel.textColor = UIColor.blackColor()

    }
}

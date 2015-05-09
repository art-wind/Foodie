//
//  VCGenerator.swift
//  Foodie
//
//  Created by 许Bill on 15-5-9.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class VCGenerator{
    class func detailStatusVCGenerator()-> DetailStatusViewController {
        let nibname = VCNibname.DetailStatusVC.rawValue
        let detailStatusVC = DetailStatusViewController(nibName: nibname, bundle: nil)
        detailStatusVC.modalTransitionStyle = .PartialCurl
        return detailStatusVC
    }
}
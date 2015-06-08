//
//  DateLabelSetter.swift
//  Foodie
//
//  Created by 许Bill on 15-6-8.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
import UIKit
class DateLabelSetter {
    class func setLabel(label:UILabel,dateString string:String){
        let formatter = NSDateFormatter()
        //MM-dd
        formatter.dateFormat = "HH:mm:ss"
//        let date = formatter.dateFromString(string)
//        label.text = formatter.stringFromDate(date!)
    }
}
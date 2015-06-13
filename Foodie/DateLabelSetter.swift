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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000+08:00'"
//        formatter.timeZone = NSTimeZone(name: "CST")
        let date = formatter.dateFromString(string)
        let currentDate = NSDate()
        
        let displayText = generateText(date, currentDate: currentDate)
        if displayText == "" {
            let difference = currentDate.timeIntervalSinceDate(date!)
            let int = NSInteger(difference)
            
            var hour = int / (60*60)
            var minute = int / 60
            
            if hour == 0 {
                label.text = "\(minute+1) 分钟前"
            }
            else{
                    label.text = "\(hour)小时以前"
            }
        }
        else{
            label.text = displayText
        }
        
        
        
    }
    class func generateText (date:NSDate?,currentDate current:NSDate) -> String{
        let dateComponent = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date!)
        let year = dateComponent.year
        let month = dateComponent.month
        let day = dateComponent.day
        
        
        
        let dateComponentCurrent = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: current)
        let yearCurrent = dateComponentCurrent.year
        let monthCurrent = dateComponentCurrent.month
        let dayCurrent = dateComponentCurrent.day
        if year != yearCurrent {
            return "\(yearCurrent - year)年前"
        }
        else{
            if month != monthCurrent {
                return "\(monthCurrent - month)月前"
            }
            else{
                if day != dayCurrent {
                    return "\(dayCurrent - day)天前"
                }
                else{
                    return ""
                }
            }
        }
    }
}
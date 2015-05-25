//
//  SocialInfo.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class SocialInfo  {
    var sourceID:Int?
    var targetID:String?
    var iconImage:String?
    var messageNum:String?
    var followNum:String?
    var fansNum:String?
    
    
    init(xml: XMLIndexer){
        self.sourceID = xml["SocialInfoVO"][""].element?.text?.toInt()
        self.targetID = xml["SocialInfoVO"]["Password"].element?.text?
        self.iconImage = xml["SocialInfoVO"]["Icon"].element?.text?
        self.messageNum = xml["SocialInfoVO"]["Nickname"].element?.text?
        self.followNum =  xml["SocialInfoVO"]["PhoneNum"].element?.text?
        self.fansNum =  xml["SocialInfoVO"]["PhoneNum"].element?.text?
    }
}
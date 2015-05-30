//
//  SocialInfo.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class SocialInfo  {
    var sourceID:String?
    var targetID:String?
    var iconImage:String?
    var messageNum:Int?
    var followNum:Int?
    var fansNum:Int?
    var hasFollowed:Bool
    
    
    init(xml: XMLIndexer){
        self.sourceID = xml["SourceId"].element?.text?
        self.targetID = xml["TargetId"].element?.text?
        self.iconImage = xml["IconImage"].element?.text?
        self.messageNum = xml["MessageNum"].element?.text?.toInt()
        self.followNum = xml["FollowNum"].element?.text?.toInt()
        self.fansNum =  xml["FansNum"].element?.text?.toInt()
        if(xml["HasFollowed"].element?.text=="true"){
            self.hasFollowed = true
        }else{
            self.hasFollowed = false
        }
    }
    
    class func convertSocialInfo(xml: XMLIndexer) -> SocialInfo{
        var socialInfo = SocialInfo(xml: xml["SocialInfoVO"])
        return socialInfo
    }
}
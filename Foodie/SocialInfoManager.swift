//
//  SocialInfoManager.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class SocialInfoManager {
    class func personalPageRequest(source_id:String, target_id:String)->NSMutableURLRequest{
        let parametersDictionary = ["source_id":source_id,"target_id":target_id]
        return RequestGenerator.generateRequest("PersonalPageService", parametersDictionary: parametersDictionary)
    }
    
    class func getSocialInfoFromData(data:NSData)->SocialInfo{
        let xml = SWXMLHash.parse(data)
        return SocialInfo.convertSocialInfo(xml)
    }
}
//
//  Status.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class Status{
    var id:String?
    var user_id:String?
    var nickname:String?
    var picture:String?
    var content:String?
    var time:String?
    var address:String?
    var latitude:String?
    var longtitude:String?
    var likeNum:Int?
    var commentNum:Int?
    
    var tag:String?
    var user_nickname:String?
    var user_icon:String?
    
    init(xml: XMLIndexer){
        self.id = xml["Id"].element?.text?
        self.user_id = xml["UserId"].element?.text?
        self.nickname = xml["Nickname"].element?.text?
        self.picture = xml["Picture"].element?.text?
        self.content = xml["Content"].element?.text?
        self.address =  xml["Address"].element?.text?
        self.latitude =  xml["Latitude"].element?.text?
        self.longtitude =  xml["Longtitude"].element?.text?
        self.likeNum =  xml["LikeNum"].element?.text?.toInt()
        self.commentNum = xml["CommentNum"].element?.text?.toInt()
//        self.tag =  xml["Tag"].element?.text?
        
    }
    class func convertStatus(xml: XMLIndexer) -> Status{
        var status = Status(xml: xml["StatusVO"])
        return status
    }
    class func convertStatusList(xml: XMLIndexer) -> [Status]{
        var statusList = [Status]()
        for status in xml["StatusVOList"]["StatusVO"]{
            statusList.append(Status(xml: status))
        }
        return statusList
    }
    
}
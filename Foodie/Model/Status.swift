//
//  Status.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class Status{
    var id:Int?
    var author:String?
    var picture:String?
    var content:String?
    var time:String?
    var address:String?
    var latitude:String?
    var longtitude:String?
    var likeNum:Int?
    var tag:String?
    
    var commentNum:Int?
    var user_nickname:String?
    var user_icon:String?
    
    init(xml: XMLIndexer){
        self.id = xml["StatusVO"]["Id"].element?.text?.toInt()
        self.author = xml["StatusVO"]["Author"].element?.text?
        self.picture = xml["StatusVO"]["Picture"].element?.text?
        self.content = xml["StatusVO"]["Content"].element?.text?
        self.time =  xml["StatusVO"]["Time"].element?.text?
        self.address =  xml["StatusVO"]["Address"].element?.text?
        self.latitude =  xml["StatusVO"]["Latitude"].element?.text?
        self.longtitude =  xml["StatusVO"]["Longtitude"].element?.text?
        self.likeNum =  xml["StatusVO"]["likeNum"].element?.text?.toInt()
        self.tag =  xml["StatusVO"]["Tag"].element?.text?
        
        //TODO
    }
    
    class func convertStatus(xml: XMLIndexer) -> Status{
        var status = Status(xml: xml)
        return status
    }
    
    
    class func convertStatusList(xml: XMLIndexer) -> [Status]{
        //TODO xml格式
        var statusList = [Status]()
        for status in xml["StatusVOList"] {
            statusList.append(Status.convertStatus(status))
        }
        return statusList
    }
    
}
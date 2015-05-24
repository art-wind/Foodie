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
    var likeNum:String?
    var tag:String?

    init(xml: XMLIndexer){
        self.id = xml["root"]["header"]["id"].element?.text?.toInt()
        self.content = "HZX_TEST"
    }
    
    class func convertStatus(xml: XMLIndexer) -> Status{
        //TODO xml格式
        var status = Status(xml: xml)
        return status
    }
    
    
    class func convertStatusList(xml: XMLIndexer) -> [Status]{
        //TODO xml格式
        var statusList = [Status]()
        return statusList
    }
    
}
//
//  StatusManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class StatusManager{
    
    //发状态  TODO
    class func postStateRequest(user_id:String,nickname:String,pic_url:String,content:String,address:String)->
        NSMutableURLRequest{
            let parametersDictionary = ["user_id":user_id,"nickname":nickname,"pic_url":pic_url,"content":content,"address":address,"latitude":"0"
                ,"longitude":"0"]
        return RequestGenerator.generateRequest("StatusService", parametersDictionary: parametersDictionary)
    }
    
    //为状态点赞
    class func admireStatusRequest(status_id:String)->NSMutableURLRequest{
        let parametersDictionary = ["status_id":status_id]
        return RequestGenerator.generateRequest("AdmireStatusService", parametersDictionary: parametersDictionary)
    }
    
    //广场
    class func squareStatusRequest(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("SquareService", parametersDictionary: parametersDictionary)
    }
    
    
    //朋友圈
    class func momentsStatusRequest(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("MomentsService", parametersDictionary: parametersDictionary)
    }
    
    //根据id找到状态
    class func statusByUserRequset(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("FriendsStatusService", parametersDictionary: parametersDictionary)
    }
    
    class func getStatusFromData(data:NSData)->Status{
        let xml = SWXMLHash.parse(data)
        return Status.convertStatus(xml)
    }
    
    class func getStatusListFromData(data:NSData)->[Status]{
        let xml = SWXMLHash.parse(data)
        return Status.convertStatusList(xml)
        
    }
}
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
    func postStateRequest()->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/StatusService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        return urlRequest
        
    }
    
    //为状态点赞
    func admireStatusRequest(status_id:Int)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/AdmireStatusService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(status_id, forKey: "status_id")
        return urlRequest
        
    }

    //朋友圈
    func momentsStatusRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/MomentsService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(user_id, forKey: "user_id")
        urlRequest.setValue(pageNum, forKey: "pageNum")
        return urlRequest
    }
    
    //根据id找到状态
    func statusByUserRequset(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/FriendsStatusService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(user_id, forKey: "user_id")
        urlRequest.setValue(pageNum, forKey: "pageNum")
        return urlRequest
    }
    
    //type2
    func getStatusFromData(data:NSData)->Status{
        let xml = SWXMLHash.parse(data)
        return Status.convertStatus(xml)
        
    }
    
    func getStatusListFromData(data:NSData)->[Status]{
        let xml = SWXMLHash.parse(data)
        return Status.convertStatusList(xml)
        
    }
}
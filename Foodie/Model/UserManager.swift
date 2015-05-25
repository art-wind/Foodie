//
//  UserManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class UserManager {
    //Request
    class func loginRequest(phoneNumber:String, pwd:String)->NSMutableURLRequest{
        let parametersDictionary = ["phoneNumber":phoneNumber,"pwd":pwd]
        return UserManager.generateRequest("LoginService", parametersDictionary: parametersDictionary)
    }
    class func registerRequest(phoneNumber:String, pwd:String,nickname:String)->NSMutableURLRequest{
        let parametersDictionary = ["phoneNumber":phoneNumber,"pwd":pwd,"nickname":nickname]
        return UserManager.generateRequest("RegisterService", parametersDictionary: parametersDictionary)
    }
    class func fanListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":"\(user_id)","pageNum":"\(pageNum)"]
        return UserManager.generateRequest("AdmiredPersonService", parametersDictionary: parametersDictionary)
    }
    class func followersListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":"\(user_id)","pageNum":"\(pageNum)"]
        return UserManager.generateRequest("AdmirePersonService", parametersDictionary: parametersDictionary)
    }
    
    //type2
    class func getUserFromData(data:NSData)->User{
        let xml = SWXMLHash.parse(data)
        return User.convertUser(xml)
    }
    
    class func getUserListFromData(data:NSData)->[User]{
        let xml = SWXMLHash.parse(data)
        return User.convertUserList(xml)
        
    }
    
    class func generateRequest(service:String,parametersDictionary:[String:String])->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/"+service
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        
        //set parameter
        var str = ""
        for (name,value) in parametersDictionary {
            str += "\(name)=\(value)&"
        }
        var nsstr = str as NSString
        nsstr = nsstr.substringToIndex(nsstr.length - 1)
        urlRequest.HTTPBody = nsstr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        return urlRequest
    }
    
    
    
    
}
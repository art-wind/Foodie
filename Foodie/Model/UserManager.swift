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
        return RequestGenerator.generateRequest("LoginService", parametersDictionary: parametersDictionary)
    }
    class func registerRequest(phoneNumber:String, pwd:String,nickname:String)->NSMutableURLRequest{
        let parametersDictionary = ["phoneNumber":phoneNumber,"pwd":pwd,"nickname":nickname]
        return RequestGenerator.generateRequest("RegisterService", parametersDictionary: parametersDictionary)
    }
    class func fanListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":"\(user_id)","pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("AdmiredPersonService", parametersDictionary: parametersDictionary)
    }
    class func followersListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":"\(user_id)","pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("AdmirePersonService", parametersDictionary: parametersDictionary)
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
    
    
    
    
    
    
}
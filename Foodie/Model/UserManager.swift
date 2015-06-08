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
    class func modifyRequest(user_id:String, phoneNum:String,pwd:String,nickname:String,iconURL:String)->NSMutableURLRequest{
        let parametersDictionary = ["id":user_id,"phoneNum":phoneNum,"pwd":pwd,"nickname":nickname,"iconURL":iconURL]
        return RequestGenerator.generateRequest("SettingService", parametersDictionary: parametersDictionary)
    }
    
    
    class func fanListRequest(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("AdmiredPersonService", parametersDictionary: parametersDictionary)
    }
    class func followeesListRequest(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("AdmirePersonService", parametersDictionary: parametersDictionary)
    }
    
    //type = 0为取消关注，type = 1为加关注
    class func followRequest(follower_id:String, followee_id:String,type:Int)->NSMutableURLRequest{
        let parametersDictionary = ["Follower_id":follower_id,"Followee_id":followee_id,"type":"\(type)"]
        return RequestGenerator.generateRequest("FollowService", parametersDictionary: parametersDictionary)
    }

    //设置个人信息 TODO
    class func settingRequest(user_id:String, pwd:String,nickname:String,icon:String)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pwd":pwd,"nickName":nickname,"icon":icon]
        return RequestGenerator.generateRequest("SettingService", parametersDictionary: parametersDictionary)
    }
    
    
    class func getUserFromData(data:NSData)->User{
        let xml = SWXMLHash.parse(data)
        return User.convertUser(xml)
    }
    
    class func getUserListFromData(data:NSData)->[User]{
        let xml = SWXMLHash.parse(data)
        return User.convertUserList(xml)
        
    }
    
    
    
    
    
    
}
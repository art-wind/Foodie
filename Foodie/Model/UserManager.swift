//
//  UserManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class UserManager {
    
    //TODO hzx:setvalue不知道对不对
    
    //Request
    class func loginRequest(user_id:Int, pwd:String)->NSMutableURLRequest{

        let urlStr = "http://115.29.138.163:8080/Foodie/LoginService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(user_id, forKey: "user_id")
        urlRequest.setValue(pwd, forKey: "pwd")
        return urlRequest
        
    }
    //暂时就用户名和密码注册
    class func registerRequest(phoneNumber:String, pwd:String,nickname:String)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/RegisterService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(phoneNumber, forHTTPHeaderField: "phoneNum")
        urlRequest.setValue(pwd, forHTTPHeaderField: "pwd")
        urlRequest.setValue(nickname, forHTTPHeaderField: "nickname")
        return urlRequest
    }
    
    class func fanListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/AdmiredPersonService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(user_id, forKey: "user_id")
        urlRequest.setValue(pageNum, forKey: "pageNum")
        return urlRequest
    }
    class func followersListRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let urlStr = "http://115.29.138.163:8080/Foodie/AdmirePersonService"
        let url = NSURL(string:urlStr)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "Post"
        urlRequest.setValue(user_id, forKey: "user_id")
        urlRequest.setValue(pageNum, forKey: "pageNum")
        return urlRequest
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

  
    //GET 请求
    class func requestUrl(urlString: String){
        var url: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error? != nil) {
                //Handle Error here
            }else{
                //Handle data in NSData type
            }
            
        })
    }
    
    
  


}
//
//  User.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/8.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//
import Foundation


class User {

    var id:String?
    var username:String?
    var password:String?
    var icon:String?
    var nickname:String?
    var phoneNum:String?
 
    init(xml: XMLIndexer){
        self.id = xml["Id"].element?.text?
        self.password = xml["Password"].element?.text?
        self.icon = xml["Icon"].element?.text?
        self.nickname = xml["Nickname"].element?.text?
        self.phoneNum =  xml["PhoneNum"].element?.text?
    }
    
    class func convertUser(xml: XMLIndexer) -> User{
        var user = User(xml: xml["UserVO"])
        return user
    }

    class func convertUserList(xml: XMLIndexer) -> [User]{
        var userList = [User]()
        for user in xml["UserVOList"]["UserVO"] {
            userList.append(User(xml: user))
        }
        return userList
    }
    
    
    
}

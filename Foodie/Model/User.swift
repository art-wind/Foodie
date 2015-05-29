//
//  User.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/8.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//
import Foundation


class User {
    var id:Int?
    var username:String?
    var password:String?
    var icon:String?
    var nickname:String?
    var phoneNum:String?
    
    //    init(id:Int, username:String, password:String,icon:String,nickname:String,phoneNum:String){
    //        self.id = id
    //        self.username = username
    //        self.password = password
    //        self.icon = icon
    //        self.nickname = nickname
    //        self.phoneNum = phoneNum
    //
    //    }
    
    
    
    
    init(xml: XMLIndexer){
        self.id = xml["Id"].element?.text?.toInt()
        self.password = xml["Password"].element?.text?
        self.icon = xml["Icon"].element?.text?
        self.nickname = xml["Nickname"].element?.text?
        self.phoneNum =  xml["PhoneNum"].element?.text?
    }
    
    class func convertUser(xml: XMLIndexer) -> User{
        println(xml["UserVO"]["Id"].element?.text?.toInt())
        println(xml["UserVO"]["Password"].element?.text?)
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

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
    
    init(id:Int, username:String, password:String,icon:String,nickname:String,phoneNum:String){
        self.id = id
        self.username = username
        self.password = password
        self.icon = icon
        self.nickname = nickname
        self.phoneNum = phoneNum
        
    }
    
    
  
    
}

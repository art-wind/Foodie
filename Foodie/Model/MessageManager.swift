//
//  MessageManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class MessageManager {
    class func messageRequest(user_id:Int, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":"\(user_id)","pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("MessageService", parametersDictionary: parametersDictionary)
    }
}

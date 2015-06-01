//
//  MessageManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class MessageManager {
    class func messageRequest(user_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["user_id":user_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("MessageService", parametersDictionary: parametersDictionary)
    }
    
    
    class func getMessageFromData(data:NSData)->Message{
        let xml = SWXMLHash.parse(data)
        return Message.convertMessage(xml)
    }
    
    class func getMessageListFromData(data:NSData)->[Message]{
        let xml = SWXMLHash.parse(data)
        return Message.convertMessageList(xml)
    }
}

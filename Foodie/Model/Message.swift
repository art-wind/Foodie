//
//  Status.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class Message{
    var id:String?
    var userId:String?
    var targetId:String?
    var type:Int?
    var hasRead:Bool?
   
    init(xml: XMLIndexer){
        self.id = xml["Id"].element?.text?
        self.userId = xml["UserId"].element?.text?
        self.targetId = xml["TargetId"].element?.text?
        self.type = xml["Type"].element?.text?.toInt()
        if(xml["HasRead"].element?.text=="true"){
            self.hasRead = true
        }else{
            self.hasRead = false
        }
    }
    
    class func convertMessage(xml: XMLIndexer) -> Message{
        var message = Message(xml: xml["MessageVO"])
        return message
    }
    class func convertMessageList(xml: XMLIndexer) -> [Message]{
        var messageList = [Message]()
        for message in xml["MessageVOList"]["MessageVO"]{
            messageList.append(Message(xml: message))
        }
        return messageList
    }
    
}
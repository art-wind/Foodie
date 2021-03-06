//
//  CommentManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class CommentManager {
    class func commentReadRequest(status_id:String, pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["status_id":status_id,"pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("CommentReadService", parametersDictionary: parametersDictionary)
    }
    
    class func commentSendRequest(target_id:String, user_id:String,icon:String,nickname:String,content:String)->NSMutableURLRequest{
        let parametersDictionary = ["target_id":target_id,"user_id":user_id,"icon":icon,"nickname":nickname,"content":content]
        return RequestGenerator.generateRequest("CommentSendService", parametersDictionary: parametersDictionary)
    }
    
    class func getCommentFromData(data:NSData)->Comment{
        let xml = SWXMLHash.parse(data)
        return Comment.convertComment(xml)
    }
    
    class func getCommentListFromData(data:NSData)->[Comment]{
        let xml = SWXMLHash.parse(data)
        return Comment.convertCommentList(xml)
    }
    
}

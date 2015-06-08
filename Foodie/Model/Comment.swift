//
//  Status.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class Comment{
    var id:String?
    var user_id:String?
    var target_id:String?
    var content:String?
    var icon:String?
    var nickname:String?
    var date:String?
    init(xml: XMLIndexer){
        self.id = xml["Id"].element?.text?
        self.user_id = xml["UserId"].element?.text?
        self.target_id = xml["Nickname"].element?.text?
        self.content = xml["Content"].element?.text?
        self.icon = xml["Icon"].element?.text?
        self.nickname = xml["Nickname"].element?.text
        self.date = xml["Time"].element?.text
        println("Date:")
        println(self.date)
    }
    class func convertComment(xml: XMLIndexer) -> Comment{
        var comment = Comment(xml: xml["CommentVO"])
        return comment
    }
    class func convertCommentList(xml: XMLIndexer) -> [Comment]{
//        println(xml)
        var commentList = [Comment]()
        for comment in xml["CommentVOList"]["CommentVO"]{
            commentList.append(Comment(xml: comment))
        }
        return commentList
    }
    
    
}
//
//  SearchManager.swift
//  Foodie
//
//  Created by 许Bill on 15-6-1.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class SearchManager {
    //search choice = 0 搜索状态，choice = 1 搜索用户
    class func searchRequest(key:String, choice:Int,pageNum:Int)->NSMutableURLRequest{
        let parametersDictionary = ["key":key,"choice":"\(choice)","pageNum":"\(pageNum)"]
        return RequestGenerator.generateRequest("SearchService", parametersDictionary: parametersDictionary)
    }
}
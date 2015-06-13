//
//  RequestGenerator.swift
//  Foodie
//
//  Created by 许Bill on 15-5-26.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class RequestGenerator {
    class func generateRequest(service:String,parametersDictionary:[String:String])->NSMutableURLRequest{
        let urlStr = Constants.urlBasicPath+service
        let url = NSURL(string:urlStr)
        //println(urlStr)
        
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "POST"
        
        //set parameter
        var str = ""
        for (name,value) in parametersDictionary {
            str += "\(name)=\(value)&"
        }
        var nsstr = str as NSString
        nsstr = nsstr.substringToIndex(nsstr.length - 1)
        urlRequest.HTTPBody = nsstr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        return urlRequest
    }
}
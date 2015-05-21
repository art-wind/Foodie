//
//  UserManager.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/12.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation

class UserManager {
//    func login(User:user){
//        
//    }
    
    
    
    //TODO
    func register(){
        let parser = SWXMLHash()
        
        
    }
    
    //GET 请求
    func requestUrl(urlString: String){
        var url: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error? != nil) {
                //Handle Error here
            }else{
                //Handle data in NSData type
            }
            
        })
    }
    
    
  


}
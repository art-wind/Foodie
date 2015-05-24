//
//  ImageUpload.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
import UIKit
class ImageUpload {
    class func createRequest (image:UIImage,parameters:[String:String]) -> NSURLRequest {
        let url = NSURL(string: "\(Constants.urlBasicPath)PictureService")!
        let imageData = UIImagePNGRepresentation(image)
        
        var TWITTERFON_FORM_BOUNDARY:String = "AaB03x"
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)
        var MPboundary:String = "--\(TWITTERFON_FORM_BOUNDARY)"
        var endMPboundary:String = "\(MPboundary)--"
        var data:NSData = UIImagePNGRepresentation(image)
        var body:NSMutableString = NSMutableString()
        var filename = "p.png"
        body.appendFormat("%@\r\n",MPboundary)
        body.appendFormat("Content-Disposition: form-data; name=\"\(filename)\"; filename=\"pen111.png\"\r\n")
        body.appendFormat("Content-Type: image/png\r\n\r\n")
        var end:String = "\r\n\(endMPboundary)"
        var myRequestData:NSMutableData = NSMutableData();
        myRequestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
        myRequestData.appendData(data)
        myRequestData.appendData(end.dataUsingEncoding(NSUTF8StringEncoding)!)
        var content:String = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = myRequestData
        request.HTTPMethod = "POST"
        
        return request
    }
}
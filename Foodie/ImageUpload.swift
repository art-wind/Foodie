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
        let url = NSURL(string: "\(Constants.urlBasicPath)StatusService")!
        
        
        var imageData = UIImagePNGRepresentation(image)
//
//        var base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//        
//        request.HTTPBody = imageData
        
        
        
        var TWITTERFON_FORM_BOUNDARY:String = "AaB03x"
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)
        var MPboundary:String = "--\(TWITTERFON_FORM_BOUNDARY)"
        var endMPboundary:String = "\(MPboundary)--"
        var data:NSData = UIImagePNGRepresentation(image)
        var body:NSMutableString = NSMutableString()
        if parameters.count != 0 {
            for (key, value) in parameters {
                body.appendFormat("\(MPboundary)\r\n")
                body.appendFormat("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendFormat("Content-Type: \r\n\r\n")
                body.appendFormat("\(value)\r\n")
                println("\(key)+\(value)")
            }
        }
        var filename = "asd.png"
        // image upload
        body.appendFormat("%@\r\n",MPboundary)
        body.appendFormat("Content-Disposition: form-data; name=\"\(filename)\"; filename=\"pen111.png\"\r\n")
        body.appendFormat("Content-Type: image/png\r\n\r\n")
        var end:String = "\r\n\(endMPboundary)"
        var myRequestData:NSMutableData = NSMutableData();
        
        myRequestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
        myRequestData.appendData(imageData)
        myRequestData.appendData(end.dataUsingEncoding(NSUTF8StringEncoding)!)
        var content:String = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = myRequestData
        request.HTTPMethod = "POST"
        
        
        
        
        
//        println(base64String)
//        var err: NSError? = nil
//        var params = ["image":[ "content_type": "image/jpeg", "filename":"test.jpg", "file": base64String]]
        return request
    }
    
    
    /// Create body of the multipart/form-data request
    ///
    /// :param: parameters   The optional dictionary containing keys and values to be passed to web service
    /// :param: filePathKey  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// :param: paths        The optional array of file paths of the files to be uploaded
    /// :param: boundary     The multipart/form-data boundary
    ///
    /// :returns:            The NSData of the body of the request
    
}
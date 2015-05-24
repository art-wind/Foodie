//
//  ImageUpload.swift
//  Foodie
//
//  Created by HuZhenxuan on 15/5/24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
class ImageUpload {
    
    class func test(){
        var carData:NSMutableDictionary = NSMutableDictionary();
        var request:NSMutableURLRequest = NSMutableURLRequest();
        request.URL = NSURL(string: "YOUR URL ADDR");
        request.HTTPMethod = "POST";
        request.timeoutInterval = 10;
        var body:NSMutableData = NSMutableData();
        
        //设置表单分隔符
        var boundary:NSString = "----------------------1465789351321346";
        var contentType = NSString(format: "multipart/form-data;boundary=%@", boundary);
        request.addValue(contentType, forHTTPHeaderField: "Content-Type");
        
        //写入Info内容
        var keys:NSArray = carData.allKeys;
        for key in keys{
            body.appendData(NSString(format: "--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!);
            body.appendData(NSString(format: "Content-Disposition:form-data;name=\"%@\"\r\n\r\n", key as NSString).dataUsingEncoding(NSUTF8StringEncoding)!);
            //如果有中文进行UTF8编码
            body.appendData("\(carData.objectForKey(key) as String)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        //写入图片内容
        var ImgPath = NSHomeDirectory()+(carData.valueForKey("imageSrc") as String);
        println(ImgPath)
        body.appendData(NSString(format: "--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!);
        body.appendData(NSString(format: "Content-Disposition:form-data;name=\"%@\";filename=\"\(ImgPath)\"\r\n", "userfile").dataUsingEncoding(NSUTF8StringEncoding)!);
        var imageData:NSData = UIImageJPEGRepresentation(UIImage(contentsOfFile: ImgPath), 1);
        body.appendData("Content-Type:image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageData);
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        
        //写入尾部
        body.appendData(NSString(format: "--%@--\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!);
        request.HTTPBody = body;
        
        var urlResponse:NSHTTPURLResponse? = nil;
        var error:NSError? = NSError();
        
        //第三方判断网络是否连接
        if IJReachability.isConnectedToNetwork() {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
                if(error == nil){
                    var json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary;
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        loading.mode = MBProgressHUDMode.Text;
                        if(json["success"] != nil){
                            
                            //MBProgressHUD提示插件
                            loading.mode = MBProgressHUDMode.CustomView;
                            loading.customView = UIImageView(image: UIImage(named: "37x-Checkmark"))
                            loading.labelText = "上传成功";
                        }else if(json["failed"] != nil){
                            loading.labelText = json["failed"] as String;
                        }
                        loading.hide(true, afterDelay: 1);
                        // println(json);
                    })
                }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        loading.mode = MBProgressHUDMode.Text;
                        loading.labelText = error.localizedDescription;
                        loading.hide(true, afterDelay: 1);
                        println(error.localizedDescription);
                    })
                }
            }
        }else{
            loading.mode = MBProgressHUDMode.CustomView;
            loading.customView = UIImageView(image: UIImage(named: "Wrongmark"))
            loading.labelText = noNetworkMsg;
            loading.hide(true, afterDelay: 1);
        }
        
        
    }

}

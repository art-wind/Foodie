//
//  CacheManager.swift
//  Foodie
//
//  Created by 许Bill on 15-5-25.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CacheManager {
    
    
    class func setImageViewWithData(imageView:UIImageView,url innerURL:String){
        let innerURLString = innerURL.stringByReplacingOccurrencesOfString("\n", withString: "")
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "URLCache")
        let url = "\(Constants.pictureBasicPath)\(innerURLString)"
        fetchRequest.predicate = NSPredicate(format: "url = %@",url)
        var error:NSError?
        let fetchedObjects = context?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]
        if fetchedObjects.count > 0 {
            let cache = fetchedObjects.last!
            let imgData = cache.valueForKey("imgData") as NSData
            imageView.image = UIImage(data: imgData)
        }
        else{
            let description = NSEntityDescription.entityForName("URLCache", inManagedObjectContext: context!)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                { () -> Void in
                    
                    let data = NSData(contentsOfURL: NSURL(string: url)!)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let newElement = NSManagedObject(entity: description!, insertIntoManagedObjectContext: context!)
                        newElement.setValue(url, forKey: "url")
                        imageView.image = UIImage(data: data!)
                        newElement.setValue(data!, forKey: "imgData")
                        context?.save(&error)
                    })
                    
            })
            
            
        }
    }
    
    
    
    class func saveIcon(image:UIImage?,url innerURL:String){
        let innerURLString = innerURL.stringByReplacingOccurrencesOfString("\n", withString: "")
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "URLCache")
        let url = "\(Constants.pictureBasicPath)\(innerURLString)"
        fetchRequest.predicate = NSPredicate(format: "url = %@",url)
        var error:NSError?
        let fetchedObjects = context?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]
        if fetchedObjects.count > 0 {
            let cache = fetchedObjects.last!
            let imgData = cache.valueForKey("imgData") as NSData
        }
        else{
            let description = NSEntityDescription.entityForName("URLCache", inManagedObjectContext: context!)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                { () -> Void in
                    
                    let data = NSData()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let newElement = NSManagedObject(entity: description!, insertIntoManagedObjectContext: context!)
                        let data = UIImagePNGRepresentation(image)
                        newElement.setValue(url, forKey: "url")
                        newElement.setValue(data, forKey: "imgData")
                        context?.save(&error)
                    })
                    
            })
            
            
        }
    }
}
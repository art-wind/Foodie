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
    
    
    class func setImageViewWithData(imageView:UIImageView,url:String){
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "URLMapping")
        fetchRequest.predicate = NSPredicate(format: "url = %@",url)
        var error:NSError?
        let fetchedObjects = context?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]
        if fetchedObjects.count > 0 {
            println("Cached \(url)")
            let cache = fetchedObjects.last!
            let imgData = cache.valueForKey("imgData") as NSData
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageView.image = UIImage(data: imgData)
            })
        }
        else{
            println("New \(url)")
            let description = NSEntityDescription.entityForName("URLMapping", inManagedObjectContext: context!)
            let newElement = NSManagedObject(entity: description!, insertIntoManagedObjectContext: context!)
            newElement.setValue(url, forKey: "url")
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            newElement.setValue(data!, forKey: "imgData")
            context?.save(&error)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageView.image = UIImage(data: data!)
            })
            
        }
    }
}
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
        let fetchRequest = NSFetchRequest(entityName: "URLCache")
        var error:NSError?
        let fetchedObjects = context?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]
        if fetchedObjects.count > 0 {
            for data in fetchedObjects {
                let imgData = data.valueForKey("imgData") as NSData
                imageView.image = UIImage(data: imgData)
                println()
                
            }
                
        }
        else{
            let description = NSEntityDescription.insertNewObjectForEntityForName("URLCache", inManagedObjectContext: context!) as NSEntityDescription
            let newElement = NSManagedObject(entity: description, insertIntoManagedObjectContext: context)
            newElement.setValue(url, forKey: "url")
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                newElement.setValue(data, forKey: "imgData")
                imageView.image = UIImage(data: data!)
                context?.save(&error)
            })
            
        }
        
    }
}
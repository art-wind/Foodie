//
//  URLCache.swift
//  Foodie
//
//  Created by 许Bill on 15-5-19.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
import CoreData

class URLCache: NSManagedObject {

    @NSManaged var imgData: NSData
    @NSManaged var url: String

}

//
//  ShareVariable.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import Foundation
import UIKit
class SharedVariable {
    class func currentUser()->User?{
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        return delegate.currentUser
    }
    class func setCurrentUser(user:User?){
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.currentUser = user
    }
}
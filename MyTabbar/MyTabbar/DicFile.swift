//
//  DicFile.swift
//  MyTabbar
//
//  Created by shoule on 16/6/13.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import Foundation
import UIKit
extension NSDictionary{
    public func MYobjectForKey(aKey: AnyObject) -> AnyObject?{
       var object = self.objectForKey(aKey)
        if object==nil
        {
            object=""
        }
        return object;
    }
}


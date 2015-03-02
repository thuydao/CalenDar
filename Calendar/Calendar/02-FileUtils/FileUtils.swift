//
//  FileUtils.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 2/28/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import Foundation

extension NSObject
{
    class func td_getContentOfFileName(nameFile : String, type : String) -> String!
    {
        let path = NSBundle.mainBundle().pathForResource(nameFile, ofType: type)
        var error:NSError?
        var results = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: &error)
        return results

    }
    
    class func td_getPathForSource(nameFile : String, type: String)->String!
    {
        return NSBundle.mainBundle().pathForResource(nameFile, ofType: type)!
    }
}
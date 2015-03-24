//
//  TDGenerateDates.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/7/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//


import UIKit
import Foundation
import CoreData

let format = "dd/MM/YYYY"
let str_startDate = "01/01/2010"
let str_endDate = "01/01/2110"

class TDGenerateDates: NSObject
{
    var LunarDate = [NSManagedObject]()
    func startGenerate()
    {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            let startDate : NSDate = NSDate.td_dateFromString(str_startDate, aFormat: format)
            let endDate : NSDate = NSDate.td_dateFromString(str_endDate, aFormat: format)
            
            var tmpDate : NSDate = startDate
            while (tmpDate.td_year() <= endDate.td_year())
            {
                tmpDate = tmpDate.td_dateByAddingDays(1);
                
                var js = NSString(format: "td_getLunarDate(%.2d,%.2d,%d);", tmpDate.td_day(),tmpDate.td_month(), tmpDate.td_year())
                
                var result =  webviewSource.sharedInstance.wvTest?.td_runJS(js)
                self.saveDate(tmpDate, lunarInfor: result!)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("NotificationGenerated", object: nil)

        }
    }
    
    func saveDate(date : NSDate, lunarInfor : NSString)
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("LunarDate",
            inManagedObjectContext:
            managedContext)
        
        let entityObject = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        var arrLunarInfo = lunarInfor.componentsSeparatedByString("xxoxx")
        
        entityObject.setValue(date.td_stringFromDate(format), forKey: "duonglich")
        entityObject.setValue(arrLunarInfo[0], forKey: "amlich")
        entityObject.setValue(arrLunarInfo[1], forKey: "tenngay")
        entityObject.setValue(arrLunarInfo[2], forKey: "giodaungay")
        entityObject.setValue(arrLunarInfo[3], forKey: "tiet")
        entityObject.setValue(arrLunarInfo[4], forKey: "giohoangdao")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        LunarDate.append(entityObject)
    }
    
    func getData()
    {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"LunarDate" )
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            LunarDate = results
            self.printlnTest()
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }

    }
    
    func getData(dateString: String)
    {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"LunarDate" )
        let predicate = NSPredicate(format: "duonglich == %@", dateString)
        fetchRequest.predicate = predicate
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            LunarDate = results
            self.printlnTest()
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func getData(date: NSDate) -> NSManagedObject!
    {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"LunarDate" )
        let predicate = NSPredicate(format: "duonglich == %@", date.td_stringFromDate(format))
        fetchRequest.predicate = predicate
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            if results.count != 0 {
            var entityObject = results[0]
                return entityObject
            }
            else
            {
                self.startGenerate()
                return self.getData(date)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
             return nil;
        }
    }
    
    
    
    func printlnTest()
    {
        for var i = 0; i < LunarDate.count ; i++ {
            var entityObject = LunarDate[i]
            println(entityObject.valueForKey("tenngay")
)
        }
    }
}
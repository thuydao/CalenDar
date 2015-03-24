//
//  AppDelegate.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 2/28/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: TDCoreDataUtils, UIApplicationDelegate {

    var window: UIWindow?


    override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if firstLaunch  {
            println("Not first launch.")
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotificationName("NotificationGenerated", object: nil)
            }
        }
        else {
            println("First launch, setting NSUserDefault.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            webviewSource.sharedInstance
        }
        
        
        
        
        
        //test
        
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(18 * Double(NSEC_PER_SEC)))
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
//            var temp = TDGenerateDates()
//            temp.startGenerate()
//        }

        
        
        
        return true
    }

    override func applicationWillResignActive(application: UIApplication) {
    }

    override func applicationDidEnterBackground(application: UIApplication) {
    }

    override func applicationWillEnterForeground(application: UIApplication) {
    }

    override func applicationDidBecomeActive(application: UIApplication) {
    }

    override func applicationWillTerminate(application: UIApplication)
    {
         self.saveContext()
    }

}


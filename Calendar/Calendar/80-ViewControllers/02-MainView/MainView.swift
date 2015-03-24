//
//  MainView.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/8/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


class MainView: UIViewController
{
    var topview : TodayView!
    var calendarView : TDCalendar!
    @IBOutlet weak var lbYear: UILabel!
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGeneratedReceivedNotification:", name:"NotificationGenerated", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didScrollReceivedNotification:", name:"NotificationScrolling", object: nil)
        
        //add calendar
        calendarView = self.td_getViewFormNib("TDCalendar", index: 0) as TDCalendar
        calendarView.frame = CGRectMake(0, 100, self.view.frame.size.width, 350)
        self.view.addSubview(calendarView)
        self.lbYear.text = self.calendarView.currentDate.td_stringFromDate("YYYY")
        
        topview = self.td_getViewFormNib("TodayView", index: 0) as TodayView
        topview.frame = self.view.frame
        
        self.view .addSubview(topview)
        
        //gesture
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe"))
        downSwipe.direction = .Down
        
        topview.addGestureRecognizer(downSwipe)
        topview.userInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
        topview.addGestureRecognizer(tap)
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        calendarView.setup()
    }
    
    //touch donwload
    func handleSwipe()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .TransitionCurlDown, animations:
            {
                var y = self.view.frame.size.height - 60
                var frame : CGRect = self.topview.frame
                frame.origin.y = y
                self.topview.frame = frame
            },
            completion: { finished in
        })
    }
    
    
    //tap to topview
    func handleTap()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .TransitionCurlUp, animations:
            {
                self.topview.frame = self.view.frame
            },
            completion: { finished in
        })
    }
    
    func didGeneratedReceivedNotification(notification: NSNotification)
    {
        dispatch_async(dispatch_get_main_queue(),{
            println("reload view")
            self.topview.reLoadView(NSDate())
        })
    }
    
    func didScrollReceivedNotification(notification: NSNotification)
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.lbYear.text = self.calendarView.currentDate.td_beginOfMonth().td_dateByAddingDays(20).td_stringFromDate("YYYY")
        })
    }
}
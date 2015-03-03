//
//  TDDateUtils.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/3/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import Foundation

extension NSDate
{
    //MARK: Frame of Date
    func td_beginOfWeek() -> NSDate
    {
        var calendar = NSCalendar()
        
        var components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: self)
        var offset = components.weekday - 2
        components.day = components.day - offset
        
        return calendar.dateFromComponents(components)!
    }
    
    func td_endOfWeek() -> NSDate
    {
        var calendar = NSCalendar()
        
        var components = NSDateComponents()
        components.weekday = 1
        
        return self.td_beginOfWeek()
        
//        return calendar.dateByAddingComponents(components, toDate: self.td_beginOfWeek(), options: 0)!
    }
}

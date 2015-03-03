//
//  TDDateUtils.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/3/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import Foundation

let KDAY = 86400

extension NSDate
{
//    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    
    func td_currentCalendar() -> NSCalendar
    {
        return NSCalendar.currentCalendar()
    }
    
    func td_currentComponents() -> NSDateComponents
    {
        return self.td_currentCalendar().components(.YearCalendarUnit | .MonthCalendarUnit | .WeekdayCalendarUnit | .DayCalendarUnit | .WeekCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit | .WeekdayOrdinalCalendarUnit, fromDate: self)
    }
    
    //MARK: Frame of Date
    func td_beginOfWeek() -> NSDate
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .WeekdayCalendarUnit | .DayCalendarUnit, fromDate: self)
        var offset = components.weekday - 2
        
        components.day = components.day - offset
        
        return calendar.dateFromComponents(components)!
    }
    
    func td_endOfWeek() -> NSDate
    {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        
        var components = NSDateComponents()
        components.weekOfMonth = 1
        
        
        return calendar!.dateByAddingComponents(components, toDate: self.td_beginOfWeek(), options:NSCalendarOptions.WrapComponents)!.dateByAddingTimeInterval(-1)
    }
    
    func td_beginOfMonth() -> NSDate
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit, fromDate: self)
        
        return calendar.dateFromComponents(components)!
    }
    
    func td_endOfMonth() -> NSDate
    {
        let calendar = NSCalendar.currentCalendar()
        
        var components = NSDateComponents()
        components.month = 1
        
        return calendar.dateByAddingComponents(components, toDate: self.td_beginOfMonth(), options:NSCalendarOptions.WrapComponents)!.dateByAddingTimeInterval(-1)
    }
    
    //MARK : Modify Date
    
    func td_addMonth(monthNumber : NSInteger) -> NSDate
    {
        let calendar = NSCalendar.currentCalendar()
        
        var components = NSDateComponents()
        components.month = monthNumber

        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions.WrapComponents)!
    }
    
    func td_addDay(dayNumber : NSInteger) -> NSDate
    {
        return self.td_currentCalendar().dateByAddingUnit(.DayCalendarUnit, value:dayNumber, toDate: self, options: nil)!
    }
    
    func td_day() -> NSInteger
    {
        return self.td_currentComponents().day;
    }
    
    func td_month() -> NSInteger
    {
        return self.td_currentComponents().month;
    }
}

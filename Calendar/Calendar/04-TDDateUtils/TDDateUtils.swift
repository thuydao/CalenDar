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
    // MARK: Intervals In Seconds
    private class func td_minuteInSeconds() -> Double { return 60 }
    private class func td_hourInSeconds() -> Double { return 3600 }
    private class func td_dayInSeconds() -> Double { return 86400 }
    private class func td_weekInSeconds() -> Double { return 604800 }
    private class func td_monthInSeconds() -> Double { return 2629743.83 }
    private class func td_yearInSeconds() -> Double { return 31556926 }
    
    // MARK: Components
    private class func td_componentFlags() -> NSCalendarUnit { return .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .WeekCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit | .WeekdayCalendarUnit | .WeekdayOrdinalCalendarUnit | .CalendarUnitWeekOfYear }
    
    private class func td_components(#fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.td_componentFlags(), fromDate: fromDate)
    }
    
    private func td_components() -> NSDateComponents  {
        return NSDate.td_components(fromDate: self)!
    }
    
    
    // MARK: Comparing Dates
    
    func td_isEqualToDateIgnoringTime(date: NSDate) -> Bool
    {
        let comp1 = NSDate.td_components(fromDate: self)
        let comp2 = NSDate.td_components(fromDate: date)
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
    
    func td_isToday() -> Bool
    {
        return self.td_isEqualToDateIgnoringTime(NSDate())
    }
    
    func td_isTomorrow() -> Bool
    {
        return self.td_isEqualToDateIgnoringTime(NSDate().td_dateByAddingDays(1))
    }
    
    func td_isYesterday() -> Bool
    {
        return self.td_isEqualToDateIgnoringTime(NSDate().td_dateBySubtractingDays(1))
    }
    
    func td_isSameWeekAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.td_components(fromDate: self)
        let comp2 = NSDate.td_components(fromDate: date)
        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if comp1.weekOfYear != comp2.weekOfYear {
            return false
        }
        // Must have a time interval under 1 week
        return abs(self.timeIntervalSinceDate(date)) < NSDate.td_weekInSeconds()
    }
    
    func td_isThisWeek() -> Bool
    {
        return self.td_isSameWeekAsDate(NSDate())
    }
    
    func td_isNextWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + NSDate.td_weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.td_isSameYearAsDate(date)
    }
    
    func td_isLastWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - NSDate.td_weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.td_isSameYearAsDate(date)
    }
    
    func td_isSameYearAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.td_components(fromDate: self)
        let comp2 = NSDate.td_components(fromDate: date)
        return (comp1.year == comp2.year)
    }
    
    func td_isThisYear() -> Bool
    {
        return self.td_isSameYearAsDate(NSDate())
    }
    
    func td_isNextYear() -> Bool
    {
        let comp1 = NSDate.td_components(fromDate: self)
        let comp2 = NSDate.td_components(fromDate: NSDate())
        return (comp1.year == comp2.year + 1)
    }
    
    func td_isLastYear() -> Bool
    {
        let comp1 = NSDate.td_components(fromDate: self)
        let comp2 = NSDate.td_components(fromDate: NSDate())
        return (comp1.year == comp2.year - 1)
    }
    
    func td_isEarlierThanDate(date: NSDate) -> Bool
    {
        return self.earlierDate(date) == self
    }
    
    func td_isLaterThanDate(date: NSDate) -> Bool
    {
        return self.laterDate(date) == self
    }
    
    
    // MARK: Adjusting Dates
    
    func td_dateByAddingMonths(days: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.td_monthInSeconds() * Double(days)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateByAddingDays(days: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.td_dayInSeconds() * Double(days)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateBySubtractingDays(days: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.td_dayInSeconds() * Double(days)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateByAddingHours(hours: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.td_hourInSeconds() * Double(hours)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateBySubtractingHours(hours: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.td_hourInSeconds() * Double(hours)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateByAddingMinutes(minutes: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.td_minuteInSeconds() * Double(minutes)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateBySubtractingMinutes(minutes: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.td_minuteInSeconds() * Double(minutes)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func td_dateAtStartOfDay() -> NSDate
    {
        var components = self.td_components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func td_dateAtEndOfDay() -> NSDate
    {
        var components = self.td_components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func td_dateAtStartOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .WeekCalendarUnit | .WeekdayCalendarUnit
        var components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = 1 // Sunday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func td_dateAtEndOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .WeekCalendarUnit | .WeekdayCalendarUnit
        var components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = 7 // Sunday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
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
    
    // MARK: Retrieving Intervals
    
    func td_minutesAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.td_minuteInSeconds())
    }
    
    func td_minutesBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.td_minuteInSeconds())
    }
    
    func td_hoursAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.td_hourInSeconds())
    }
    
    func td_hoursBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.td_hourInSeconds())
    }
    
    func td_daysAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.td_dayInSeconds())
    }
    
    func td_daysBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.td_dayInSeconds())
    }
    
    
    // MARK: Decomposing Dates
    
    func td_nearestHour () -> Int {
        let halfHour = NSDate.td_minuteInSeconds() * 30
        var interval = self.timeIntervalSinceReferenceDate
        if  self.td_seconds() < 30 {
            interval -= halfHour
        } else {
            interval += halfHour
        }
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return date.td_hour()
    }
    
    func td_year () -> Int { return self.td_components().year  }
    func td_month () -> Int { return self.td_components().month }
    func td_week () -> Int { return self.td_components().weekOfYear }
    func td_day () -> Int { return self.td_components().day }
    func td_hour () -> Int { return self.td_components().hour }
    func td_minute () -> Int { return self.td_components().minute }
    func td_seconds () -> Int { return self.td_components().second }
    func td_weekday () -> Int { return self.td_components().weekday }
    func td_nthWeekday () -> Int { return self.td_components().weekdayOrdinal } //// e.g. 2nd Tuesday of the month is 2
    func td_monthDays () -> Int { return NSCalendar.currentCalendar().rangeOfUnit(.DayCalendarUnit, inUnit: .MonthCalendarUnit, forDate: self).length }
    func td_firstDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.td_dayInSeconds() * Double(self.td_components().weekday - 1)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).td_day()
    }
    func td_lastDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.td_dayInSeconds() * Double(self.td_components().weekday - 1)
        let distanceToEndOfWeek = NSDate.td_dayInSeconds() * Double(7)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).td_day()
    }
    func td_isWeekday() -> Bool {
        return !self.td_isWeekend()
    }
    func td_isWeekend() -> Bool {
        let range = NSCalendar.currentCalendar().maximumRangeOfUnit(.WeekdayCalendarUnit)
        return (self.td_weekday() == range.location || self.td_weekday() == range.length)
    }
    
    
    // MARK: To String
    
    
    func td_relativeTimeToString() -> String
    {
        let time = self.timeIntervalSince1970
        let now = NSDate().timeIntervalSince1970
        
        let seconds = now - time
        let minutes = round(seconds/60)
        let hours = round(minutes/60)
        let days = round(hours/24)
        
        if seconds < 10 {
            return NSLocalizedString("just now", comment: "relative time")
        } else if seconds < 60 {
            return NSLocalizedString("\(Int(seconds)) seconds ago", comment: "relative time")
        }
        
        if minutes < 60 {
            if minutes == 1 {
                return NSLocalizedString("1 minute ago", comment: "relative time")
            } else {
                return NSLocalizedString("\(Int(minutes)) minutes ago", comment: "relative time")
            }
        }
        
        if hours < 24 {
            if hours == 1 {
                return NSLocalizedString("1 hour ago", comment: "relative time")
            } else {
                return NSLocalizedString("\(Int(hours)) hours ago", comment: "relative time")
            }
        }
        
        if days < 7 {
            if days == 1 {
                return NSLocalizedString("1 day ago", comment: "relative time")
            } else {
                return NSLocalizedString("\(Int(days)) days ago", comment: "relative time")
            }
        }
        
        return ""
    }
    
    
    func td_weekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.weekdaySymbols[self.td_weekday()-1] as String
    }
    
    func td_shortWeekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.shortWeekdaySymbols[self.td_weekday()-1] as String
    }
    
    func td_veryShortWeekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.veryShortWeekdaySymbols[self.td_weekday()-1] as String
    }
    
    func td_monthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.monthSymbols[self.td_month()-1] as String
    }
    
    func td_shortMonthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.shortMonthSymbols[self.td_month()-1] as String
    }
    
    func td_veryShortMonthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.veryShortMonthSymbols[self.td_month()-1] as String
    }

    
    //MARK: Convert
    
    class func td_dateFromString(aString : String, aFormat : String) -> NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = aFormat
        let date = dateFormatter.dateFromString(aString)
        return date!
    }
    
    func td_stringFromDate(aFormat : String) -> String
    {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = aFormat
        let stringDate = dateFormatter.stringFromDate(self)
        return stringDate
    }
}

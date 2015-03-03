// Playground - noun: a place where people can play

import Foundation


    //MARK: Frame of Date
func td_beginOfWeek(date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    
    let components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .WeekdayCalendarUnit | .DayCalendarUnit, fromDate: date)
    var offset = components.weekday - 2
    components.day = components.day - offset
    
    return calendar.dateFromComponents(components)!
}


func td_endOfWeek(date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    
    var components = NSDateComponents()
    components.weekOfMonth = 1
    
    
    return calendar.dateByAddingComponents(components, toDate: td_beginOfWeek(date), options:NSCalendarOptions.WrapComponents)!.dateByAddingTimeInterval(-1)
}

func td_beginOfMonth(date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    
    let components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit, fromDate: date)
    
    return calendar.dateFromComponents(components)!
}


func td_endOfMonth(date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    
    var components = NSDateComponents()
    components.month = 1
    
    return calendar.dateByAddingComponents(components, toDate: td_beginOfMonth(date), options:NSCalendarOptions.WrapComponents)!.dateByAddingTimeInterval(-1)
}

func td_addMonth(monthNumber : NSInteger, date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    
    var components = NSDateComponents()
    components.month = monthNumber
    
    return calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions.WrapComponents)!
}

func td_addDay(dayNumber : NSInteger , date: NSDate) -> NSDate
{
    let calendar = NSCalendar.currentCalendar()
    var date = calendar.dateByAddingUnit(.DayCalendarUnit, value:dayNumber, toDate: date, options: nil)!
    return date
}

func td_day(date: NSDate) -> NSInteger
{
    let calendar = NSCalendar.currentCalendar()
    let components : NSDateComponents = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .WeekdayCalendarUnit | .DayCalendarUnit | .WeekCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit | .WeekdayOrdinalCalendarUnit, fromDate: date)
    return components.day;
}


//MARK: DEBUG & RESULTS

var str = "Hello, playground"

var date = NSDate()

var nexDate = td_addMonth(-2, date)


var begindate = td_beginOfWeek(date) as NSDate
var lastDate = td_endOfWeek(date) as NSDate
var beginMonth = td_beginOfMonth(date) as NSDate
var endMonth = td_endOfMonth(date) as NSDate


//var begindate1 = td_beginOfWeek(nexDate) as NSDate
//var lastDate1 = td_endOfWeek(nexDate) as NSDate
//var beginMonth1 = td_beginOfMonth(nexDate) as NSDate
//var endMonth1 = td_endOfMonth(nexDate) as NSDate


var ab = td_beginOfWeek(td_beginOfMonth(date))

td_day(ab)




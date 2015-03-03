// Playground - noun: a place where people can play

import Foundation

    //MARK: Frame of Date
func td_beginOfWeek(date: NSDate) -> NSDate
{
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    
    let components : NSDateComponents = calendar!.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: date)
    var offset = components.day - 2
    components.day = components.day - offset
    
    return calendar!.dateFromComponents(components)!
}


func td_endOfWeek(date: NSDate) -> NSDate
{
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    
    var components = NSDateComponents()
    components.weekOfMonth = 1
    
    
    return calendar!.dateByAddingComponents(components, toDate: td_beginOfWeek(date), options:NSCalendarOptions.WrapComponents)!.dateByAddingTimeInterval(-1)
}

var str = "Hello, playground"

var date = NSDate()



var begindate = td_beginOfWeek(date) as NSDate

var lastDate = td_endOfWeek(date) as NSDate



//
//  TDCalendar.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

let KMAX = 100
let KCOMPONENTS = 3

class TDCalendar: UIView, UIScrollViewDelegate
{
    @IBOutlet weak var svCalendarsList: UIScrollView!
    var arrItem : NSMutableArray = []
    
    var page : NSInteger = 0
    var currentDate = NSDate()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
    }
    
    func setup()
    {
         self.svCalendarsList.frame.size.height = 250
        self.svCalendarsList.pagingEnabled = true
        var n = 2 * KCOMPONENTS + 1
        
        var j = KMAX - KCOMPONENTS
        
        var frame : CGRect = self.svCalendarsList.frame
        for var i = -1 * KCOMPONENTS; i <= KCOMPONENTS; i++ {
            var temp : TDMonthView = self.initTMonthView(currentDate.td_addMonth(i))
            frame = self.svCalendarsList.frame;
            frame.origin.x = self.svCalendarsList.frame.size.width * CGFloat(j)
            temp.frame = frame
            arrItem.addObject(temp)
            j++
            self.svCalendarsList.addSubview(temp)
        }
        
        self.svCalendarsList.contentSize = CGSizeMake(CGFloat(2 * KMAX + 1)*self.svCalendarsList.frame.size.width, self.svCalendarsList.frame.size.height)
        
        self.scrollToCenter()
    }
    
    func initTMonthView(date : NSDate) -> TDMonthView
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var clv = UICollectionView(frame: CGRectMake(0, 0, self.svCalendarsList.frame.size.width, 220),  collectionViewLayout: layout)
        
        return TDMonthView(clvMonth: clv, date: date)
    }
    
    //MARK ScrollView
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var index: Int = Int (scrollView.contentOffset.x / scrollView.frame.size.width)
        if self.page != index {
            
            var frame = self.svCalendarsList.frame
            
            if self.page > index {
                var first : TDMonthView = self.arrItem[0] as TDMonthView
                var temp : TDMonthView = self.arrItem[self.arrItem.count - 1] as TDMonthView
                self.arrItem.removeObjectAtIndex(self.arrItem.count - 1)
                temp.currentDate = first.currentDate.td_addMonth(-1)
                temp.reload()
                frame.origin.x = first.frame.origin.x - first.frame.size.width
                temp.frame = frame
                self.arrItem.insertObject(temp,atIndex: 0)
            }
            else if self.page < index {
                
                var last : TDMonthView = self.arrItem[self.arrItem.count - 1] as TDMonthView
                var temp : TDMonthView = self.arrItem[0] as TDMonthView
                 self.arrItem.removeObjectAtIndex(0)
                temp.currentDate = last.currentDate.td_addMonth(1)
                temp.reload()
                frame.origin.x = last.frame.origin.x + last.frame.size.width
                temp.frame = frame
                self.arrItem.addObject(temp)
               
                self.svCalendarsList.addSubview(temp)
            }
            self.page = index
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func reuse()
    {
        println(self.page)
        println(KMAX)
    }
    
    func scrollToCenter()
    {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            var frame : CGRect = self.svCalendarsList.frame
            self.page = KMAX
            frame.origin.x = self.svCalendarsList.frame.size.width * CGFloat(KMAX)
            self.svCalendarsList.scrollRectToVisible(frame, animated: false)
        }
    }
}
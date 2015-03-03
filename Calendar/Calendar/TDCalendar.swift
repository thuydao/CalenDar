//
//  TDCalendar.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

let KCOMPONENTS = 3

class TDCalendar: UIView
{
    @IBOutlet weak var svCalendarsList: UIScrollView!
    var arrItem : NSMutableArray = []
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup()
    {
        self.svCalendarsList.pagingEnabled = true
        var n = 2 * KCOMPONENTS + 1
        
        var j = 0
        for var i = -1 * KCOMPONENTS; i <= KCOMPONENTS; i++ {
            println(i)
            var temp : TDMonthView = self.initTMonthView(NSDate().td_addDay(i))
            
            temp.frame = self.svCalendarsList.frame;
            temp.frame.origin.x = self.svCalendarsList.frame.size.width * CGFloat(j)
            j++
            self.svCalendarsList.addSubview(temp)
        }
        
        self.svCalendarsList.contentSize = CGSizeMake(CGFloat(n)*self.svCalendarsList.frame.size.width, self.svCalendarsList.frame.size.height)
    }
    
    func initTMonthView(date : NSDate) -> TDMonthView
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var clv = UICollectionView(frame: CGRectMake(0, 0, self.svCalendarsList.frame.size.width, 220),  collectionViewLayout: layout)
        
        return TDMonthView(clvMonth: clv, date: date)
    }
}
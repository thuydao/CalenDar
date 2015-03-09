//
//  TDCalendar.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

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
        
        var j = 0
        
        var frame : CGRect = self.svCalendarsList.frame
        for var i = -1 * KCOMPONENTS; i <= KCOMPONENTS; i++ {
            var temp : TDMonthView = self.initTMonthView(currentDate.td_dateByAddingMonths(i))
            frame = self.svCalendarsList.frame;
            frame.origin.x = self.svCalendarsList.frame.size.width * CGFloat(j)
            temp.frame = frame
            arrItem.addObject(temp)
            j++
            self.svCalendarsList.addSubview(temp)
        }
        
        self.svCalendarsList.contentSize = CGSizeMake(CGFloat(n)*self.svCalendarsList.frame.size.width, self.svCalendarsList.frame.size.height)
        //hide scroll indicator
        self.svCalendarsList.showsHorizontalScrollIndicator = false
        self.svCalendarsList.showsVerticalScrollIndicator = false
        
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
        println(scrollView.contentOffset.x)
        var index: Int = Int (scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if (scrollView.contentOffset.x < 0)
        {
            self.reloadDateALlItem()
        }
            
        else if (index >= 2 * KCOMPONENTS)
        {
            self.reloadDateALlItem()
        }
            
        else
        {
            if (index != self.page)
            {
                self.page = index
                self.currentDate = (arrItem[index] as TDMonthView).currentDate
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    
    func reloadDateALlItem()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .TransitionFlipFromLeft, animations:
            {
                var j = 0
                for var i = -1 * KCOMPONENTS; i <= KCOMPONENTS; i++ {
                    var temp : TDMonthView = self.arrItem[j] as TDMonthView
                    j++
                    temp.currentDate = self.currentDate.td_dateByAddingMonths(i)
                    temp .reload()
                }
                
            },
            completion: { finished in
                self.scrollToCenter()
        })
    }
    
    func scrollToCenter()
    {
        var n = 2 * KCOMPONENTS + 1
        var frame : CGRect = self.svCalendarsList.frame
        self.page = n
        frame.origin.x = self.svCalendarsList.frame.size.width * CGFloat(KCOMPONENTS)
        self.svCalendarsList.scrollRectToVisible(frame, animated: false)
    }
}
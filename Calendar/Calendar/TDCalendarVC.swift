

//
//  TDCalendarVC.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


class TDCalendarVC: UIViewController
{
    var item : TDMonthView!
 
    override func viewDidLoad() {
        item = self.td_getViewFormNib("TDMonthView", index: 0) as TDMonthView
        item.frame = CGRectMake(10, 50, item.frame.size.width, item.frame.size.height)
        item.backgroundColor = UIColor.redColor()
        self.view.addSubview(item)
    }
}
//
//  MonthVC.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


class MonthVC: UIViewController
{
    required init(coder aDecoder: NSCoder) {
        calendar = JTCalendar()
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
    @IBOutlet weak var calendarContentView: JTCalendarContentView!
    var calendar : JTCalendar
    
    override func viewDidLoad() {
        self.calendar = JTCalendar()
    }
}

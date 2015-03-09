//
//  MainView.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/8/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


class MainView: UIViewController
{
    var topview : TodayView!
    override func viewDidLoad() {
        topview = self.td_getViewFormNib("TodayView", index: 0) as TodayView
        topview.frame = self.view.frame
        self.view .addSubview(topview)
        
        //denug
        self.view.backgroundColor = UIColor.blackColor()
        topview.backgroundColor = UIColor.redColor()
    }
}
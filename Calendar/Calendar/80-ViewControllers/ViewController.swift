//
//  ViewController.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 2/28/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func runJSPress(sender: AnyObject) {
//        var abc = webviewSource.sharedInstance.wvTest?.td_runJS("td_todayInfo(03,2015);");
//        println(abc)
        var abc = webviewSource.sharedInstance.wvTest?.td_runJS("td_getLunarDate(20,09,2109);");
        println(abc)
    }
}


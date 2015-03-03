

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
 
    override func viewDidLoad()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var clv = UICollectionView(frame: CGRectMake(0, 50, self.view.frame.size.width, 200),  collectionViewLayout: layout)
        
        item = TDMonthView(clvMonth: clv, date: NSDate())

        self.view.addSubview(item)
    }
    
    override func viewWillAppear(animated: Bool) {
        item.reload()
    }
}
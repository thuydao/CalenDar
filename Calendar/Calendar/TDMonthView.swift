//
//  TDMonthView.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


class TDMonthView: UIView, UICollectionViewDataSource, UICollectionViewDelegate
{
    var clvMonth: UICollectionView!
    var currentDate : NSDate!
    
    
    
    init(clvMonth: UICollectionView, date: NSDate)
    {
        self.clvMonth = clvMonth
        self.currentDate = date
        super.init(frame: self.clvMonth.frame)
        self.clvMonth.delegate = self
        self.clvMonth.dataSource = self
        
        var nipName = UINib(nibName: "DateItemCollectionCell", bundle:nil)
        
        self.clvMonth.registerNib(nipName, forCellWithReuseIdentifier:"Cell")
        self.clvMonth.scrollEnabled = false
        self .addSubview(self.clvMonth)
        self.clvMonth.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload()
    {
        
        self.clvMonth.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as DateItemCollectionCell
        if indexPath.section == 0 {
            switch (indexPath.row) {
            case 0:
                cell.lbTitle.text = "T2"
                break
            case 1:
                cell.lbTitle.text = "T3"
                break
            case 2:
                cell.lbTitle.text = "T4"
                break
            case 3:
                cell.lbTitle.text = "T5"
                break
            case 4:
                cell.lbTitle.text = "T6"
                break
            case 5:
                cell.lbTitle.text = "T7"
                break
            case 6:
                cell.lbTitle.text = "CN"
                break
            default:
                break
            }
        }
        else
        {
            var week : NSInteger = indexPath.section
            var day : NSInteger = indexPath.row
            var temp : NSInteger = (week - 1) * 7 + day
            let firstMonth = self.currentDate.td_beginOfMonth()
            var firstWeek = firstMonth.td_beginOfWeek()
            //process today
            if firstWeek.td_day() > 1 && firstWeek.td_day() < 8 {
                firstWeek = firstWeek.td_addDay(-3)
                firstWeek = firstWeek.td_beginOfWeek()
            }
            
            let datetmp = firstWeek.td_addDay(temp)
            
            cell.lbTitle.text = NSString(format: "%d", datetmp.td_day())
            
            if self.currentDate.td_month() == datetmp.td_month() {
                cell.lbTitle.textColor = UIColor.blackColor()
            }
            else
            {
                cell.lbTitle.textColor = UIColor.grayColor()
            }
        }
        
        return cell
    }
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            let width = self.frame.size.width
            // fix height
            if indexPath.section == 0 {
                return CGSize(width: (width - 45)/8, height: 25)
            }
            return CGSize(width: (width - 45)/8, height: 20)
    }

    private let sectionInsets = UIEdgeInsets(top: 5 , left: 5.0, bottom: 5.0, right: 0)
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
}
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
        
        var nibName = UINib(nibName: "DateItemCollectionCell", bundle:nil)
        
        self.clvMonth.registerNib(nibName, forCellWithReuseIdentifier:"Cell")
        self.clvMonth.scrollEnabled = false
        self .addSubview(self.clvMonth)
        self.clvMonth.backgroundColor = UIColor.whiteColor()
        
        //set frame
        self.clvMonth.frame = self.frame
        self.clvMonth.frame.origin.y = 0
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
                firstWeek = firstWeek.td_dateByAddingDays(-3)
                firstWeek = firstWeek.td_beginOfWeek()
            }
            
            let datetmp = firstWeek.td_dateByAddingDays(temp)
            
            cell.lbTitle.text = NSString(format: "%d", datetmp.td_day())
            cell.lbLunaTitle.text = NSString(format: "%d", datetmp.td_month())
            
            if self.currentDate.td_month() == datetmp.td_month() {
                cell.lbTitle.textColor = UIColor.blackColor()
            }
            else
            {
                cell.lbTitle.textColor = UIColor.grayColor()
            }
            

            if datetmp.td_stringFromDate("DD/MM/YYYY") == NSDate().td_stringFromDate("DD/MM/YYYY")
            {
                cell.lbTitle.textColor = UIColor.redColor()
                cell.lbLunaTitle.textColor = UIColor.redColor()
            }
            else
            {
                cell.lbTitle.textColor = UIColor.blackColor()
                cell.lbLunaTitle.textColor = UIColor.blackColor()
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
                return CGSize(width: (width - 35)/8, height: 35)
            }
            return CGSize(width: (width - 35)/8, height: 30)
    }

    private let sectionInsets = UIEdgeInsets(top: 5 , left: 5.0, bottom: 0.0, right: 5)
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    //MARK: Click To Item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.section == 0 {
            //cancel
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
                firstWeek = firstWeek.td_dateByAddingDays(-3)
                firstWeek = firstWeek.td_beginOfWeek()
            }
            
            let datetmp = firstWeek.td_dateByAddingDays(temp)
            
            if self.currentDate.td_month() == datetmp.td_month() {
               println(datetmp)
            }
            else
            {
               //cancel
            }
        }
        
    }
}
//
//  TodayView.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/8/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit
import CoreData

class TodayView : UIView
{
    @IBOutlet weak var lbDateDuongLich: UILabel!
    @IBOutlet weak var lbNgay: UILabel!
    @IBOutlet weak var lbGio: UILabel!
    @IBOutlet weak var lbNam: UILabel!
    @IBOutlet weak var lbNgayAmLich: UILabel!
    @IBOutlet weak var lbThangNamAmLich: UILabel!
    @IBOutlet weak var lbGioHoangDao: UILabel!
    
    func reLoadView(currentDate : NSDate)
    {
        var duongLich = currentDate.td_stringFromDate("dd")
        lbDateDuongLich.text = duongLich
        
        var temp = TDGenerateDates()
        var object = temp.getData(currentDate) as NSManagedObject
        if  !object.isEqual(nil) {
            var tenngay: String = object.valueForKey("tenngay") as String
            var array : NSArray = tenngay.componentsSeparatedByString(",")
            
            self.lbNgay.text = array[0] as? String
            self.lbGio.text = array[1] as? String
            self.lbNam.text = array[2] as? String
            
            self.lbNgay.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            self.lbGio.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            self.lbNam.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            self.lbGioHoangDao.text = object.valueForKey("giohoangdao") as? String
            
            var ngayAmLich : String = object.valueForKey("amlich") as String
            println(ngayAmLich)
            var AmLichArray : NSArray = ngayAmLich.componentsSeparatedByString("/")
            self.lbNgayAmLich.text = AmLichArray[0] as? String
            
            var namAmlich = "" as String
            var thangAmlich = "" as String
            
             thangAmlich = AmLichArray[1] as String
             namAmlich = AmLichArray[2] as String
            
            self.lbThangNamAmLich.text = String(format: "%@/%@", arguments: [thangAmlich, namAmlich])
        }
    }
    
}
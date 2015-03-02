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
    @IBOutlet weak var clvMonth: UICollectionView!
    var dataSource : NSMutableArray = ["x","x","x","x","x","x","x"]

//    required init(coder aDecoder: NSCoder) {
//        self.dataSource = NSMutableArray()
//        
//        var abc = ["x","x","x","x","x","x","x"] as NSMutableArray
//        
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        self.dataSource.addObject(abc)
//        super.init(coder: aDecoder)
//    }
    
    // MARK: UICollectionViewDataSource
    
    //1
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("staticcell", forIndexPath: indexPath) as UICollectionViewCell


        
        cell.backgroundColor = UIColor.greenColor()
        
        //3
        
        return cell
    }
//    // MARK: UICollectionViewDelegateFlowLayout
//    
//    //1
//    func collectionView(collectionView: UICollectionView!,
//        layout collectionViewLayout: UICollectionViewLayout!,
//        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
//            
//            let flickrPhoto =  photoForIndexPath(indexPath)
//            //2
//            if var size = flickrPhoto.thumbnail?.size {
//                size.width += 10
//                size.height += 10
//                return size
//            }
//            return CGSize(width: 100, height: 100)
//    }
//    
//    //3
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
//    
//    func collectionView(collectionView: UICollectionView!,
//        layout collectionViewLayout: UICollectionViewLayout!,
//        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//            return sectionInsets
//    }
    
}
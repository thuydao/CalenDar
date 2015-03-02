//
//  VCUtils.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit


extension UIViewController
{
    //////////// DELAY ////////////////
    func td_dealy(secs : Double, delayblock: () -> Void?)
    {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(secs * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            delayblock()!
        }
    }
    
    //////////// END DELAY ////////////////
    
    
    //////////// STORYBOARD ////////////////
    
    func td_getStoryBoardWithName(nameSB : String)->UIStoryboard?
    {
        let storyboard = UIStoryboard(name: "myStoryboardName", bundle: nil)
        return storyboard
    }
    
    func td_VCstoryBoardWithClass(nameClass : AnyClass)->UIViewController?
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier(NSStringFromClass(nameClass)) as UIViewController
        return vc
    }
    
    func td_getVCName(nameClass : AnyClass, nameStoryBoard : String) -> UIViewController?
    {
        let storyboard = self.td_getStoryBoardWithName(nameStoryBoard)
        let vc = storyboard!.instantiateViewControllerWithIdentifier(NSStringFromClass(nameClass)) as UIViewController
        return vc
    }
    
    //////////// END STORYBOARD ////////////////
    
    
    
    //////////// Flow ////////////////
    
    func td_presentVCWithClass(nameClass : AnyClass)
    {
        self.presentViewController(self.td_VCstoryBoardWithClass(nameClass)!, animated: true, completion: nil)
    }
    
    func td_presentVCWithName(name : String)
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier(name) as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //////////// END Flow ////////////////
}
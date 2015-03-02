
//
//  TDSplashScreenViewController.swift
//  Calendar
//
//  Created by thuydd on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

class TDSplashScreenVC: UIViewController
{
     override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.td_dealy(2, delayblock: { () -> Void? in
            return self.td_presentVCWithName("rootNAV")
        })
    }
}
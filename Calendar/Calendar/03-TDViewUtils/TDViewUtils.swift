//
//  TDViewUtils.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/2/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

extension UIView
{
    class func td_loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}
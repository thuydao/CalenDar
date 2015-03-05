//
//  JavaScriptUtils.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 2/28/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import UIKit

let K_HTML5_DEMO:String = "<!DOCTYPE html><html><body>%@</body></html>"

extension UIWebView
{
    class func alert() {
    }
    
    /*excute js*/
    func td_runJS(js : String)->NSString!
    {
       return  self.stringByEvaluatingJavaScriptFromString(js);
    }
    
    /*save text html5 so quickly setup and debug test static webpage*/
    func td_addBody(html : String)->String!
    {
        var res = "" as String
        
        res = NSString(format: K_HTML5_DEMO, html)
        
        return res
    }
    
    func td_loadContentString(html : String)
    {
        self.loadHTMLString(html, baseURL:nil)
    }
    
    func td_loadUrlString(url :String)
    {
        let requesturl = NSURL(string: url)
        let request = NSURLRequest(URL: requesturl!)
        self.loadRequest(request)
    }
}
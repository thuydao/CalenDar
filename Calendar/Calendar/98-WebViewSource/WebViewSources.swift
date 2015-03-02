//
//  WebViewSources.swift
//  Calendar
//
//  Created by Thuỷ Đào  on 3/1/15.
//  Copyright (c) 2015 Thuỷ Đào . All rights reserved.
//

import Foundation
import UIKit

class webviewSource: NSObject, UIWebViewDelegate
{
    var wvTest: UIWebView?
    
    class var sharedInstance: webviewSource {
        struct Static {
            static var instance: webviewSource?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = webviewSource()
            Static.instance?.wvTest = UIWebView()
            Static.instance?.wvTest?.delegate = Static.instance
            Static.instance?.loadResource()
        }
        
        return Static.instance!
    }

    
    ////// webview deleage ///////
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        print("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView!) {
        print("Webview started Loading")
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        print("Webview did finish load")
        
    }
    
    func loadResource()
    {
        var url = NSObject.td_getPathForSource("Basic", type: "html")
        self.wvTest?.td_loadUrlString(url)
    }
    
}
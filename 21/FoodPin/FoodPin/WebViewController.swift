//
//  WebViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/8/1.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://www.baidu.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    
    }

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    

}

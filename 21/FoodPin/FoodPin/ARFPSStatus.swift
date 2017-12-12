//
//  ARFPSStatus.swift
//  ARFPSStatus
//
//  Created by andyron on 2017/9/28.
//  Copyright © 2017年 andyron. All rights reserved.
//
//  Author: AndyRon <rongming.2008@163.com>
//      blog: http://andyron.com
//      jianshu: http://www.jianshu.com/u/efce1a2a95ab
//      github: https://github.com/andyRon 
//

import UIKit
import Foundation

class ARFPSStatus: NSObject {

    
    
    open class var shared: ARFPSStatus {
        return ARFPSStatus()
    }
    
    var fpsLabel: UILabel!
    
    var displayLink: CADisplayLink?
    
    var lastTime: TimeInterval = 0
    
    var count: Double = 0
    
    var fpsHandler: ((_ fpsValue: Double) -> Void)?
    
    deinit {
        displayLink?.isPaused = true
        displayLink?.remove(from: RunLoop.current, forMode: .commonModes)
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActiveNotification), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActiveNotification), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTick))
        displayLink?.isPaused = true
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
        
        fpsLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width/2 + 50, y: 0, width: 50, height: 20))
        fpsLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fpsLabel.textColor = UIColor(red: 0.33, green: 0.84, blue: 0.43, alpha: 1.00)
        fpsLabel.textAlignment = .right
        fpsLabel.tag = 101
        
    }

    @objc func applicationDidBecomeActiveNotification() {
        displayLink?.isPaused = false
    }
    
    @objc func applicationWillResignActiveNotification() {
        displayLink?.isPaused = true
    }
    
    @objc func displayLinkTick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp;
            return
        }
        count = count + 1
        let interval: TimeInterval = link.timestamp - lastTime
        if interval < 1 {
            return
        }
        lastTime = link.timestamp
        let fps = count / interval
        count = 0
        
        let text = "\(Int(fps)) FPS"
        fpsLabel?.text = text
        
        if ((fpsHandler) != nil) {
            fpsHandler!(round(fps))
        }

    }
    
    func open() {
        let rootVCViewSubViews = UIApplication.shared.delegate?.window??.rootViewController?.view.subviews
        
        for var label: UIView in rootVCViewSubViews! {
            if label.isKind(of: UILabel.self) && label.tag == 101 {
                return
            }
        }
        
        displayLink?.isPaused = false
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(fpsLabel)
    }
    
    func openWithHandler(handler: @escaping (_ fpsValue: Double) -> Void) {
        ARFPSStatus.shared.open()
        fpsHandler = handler
    }
    
    
}

//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/7/30.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!

    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: .normal)
        case 2: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }
    }

    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default: break
        }
    }

}

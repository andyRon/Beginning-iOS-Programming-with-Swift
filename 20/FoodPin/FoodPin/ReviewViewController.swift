//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/7/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var topImageView: UIImageView!
    

    @IBOutlet var closeButton: UIButton!
    
    var restaurant: RestaurantMO?

    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
//        containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
//        containerView.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
        
        if let restaurant = self.restaurant {
            let image = UIImage(data: restaurant.image as! Data)
            backgroundImageView.image = image
            topImageView.image = image
        }
        
        
        closeButton.transform = CGAffineTransform.init(scaleX: 1000, y: 0)
        
    
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform.identity
            
            
        })
        
        //spring animation
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
//            self.containerView.transform = CGAffineTransform.identity
//        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            self.closeButton.transform = CGAffineTransform.identity
            
        }, completion: nil)
    }



}

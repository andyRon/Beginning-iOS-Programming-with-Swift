//
//  RestaurantDetailTableViewCell.swift
//  FoodPin
//
//  Created by andyron on 2017/7/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {

    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueLabel.numberOfLines = 0
        
    }

}

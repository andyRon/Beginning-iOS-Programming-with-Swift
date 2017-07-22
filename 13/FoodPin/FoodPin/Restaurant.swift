//
//  Restaurant.swift
//  FoodPin
//
//  Created by andyron on 2017/7/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""
    
    init(name: String, type: String, location: String, phone: String, image: String,
         isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
        
        
    }
}

//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/7/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {

    @IBOutlet var restaurantImageView: UIImageView!
//    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var locationLabel: UILabel!
//    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(named: restaurant.image)
//        nameLabel.text = restaurant.name
//        locationLabel.text = restaurant.location
//        typeLabel.text = restaurant.type
        
        // 修改tableview的样式
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        // 修改分割线的颜色
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        // 移除空cell的分割线
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        title = restaurant.name
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been herebefore" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .lightContent
//    }
}

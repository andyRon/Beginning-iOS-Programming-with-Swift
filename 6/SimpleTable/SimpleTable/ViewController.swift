//
//  ViewController.swift
//  SimpleTable
//
//  Created by andyron on 2017/7/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "PetiteOyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh'sChocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats AndDeli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional","Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                     for: indexPath)
        // Configure the cell...
        let restaurantName = restaurantNames[indexPath.row]
        cell.textLabel?.text = restaurantName
        
        let imageName = restaurantName.lowercased().replacingOccurrences(of: " ", with: "")
        if let image = UIImage(named: imageName) {
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = UIImage(named: "restaurant")
        }
        
        return cell
            
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


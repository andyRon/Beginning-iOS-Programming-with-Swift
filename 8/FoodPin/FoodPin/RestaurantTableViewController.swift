//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/7/10.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "PetiteOyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh'sChocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats","Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina","Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg",
                            "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg",
                            "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg",
                            "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg",
                            "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg",
                            "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "NewYork", "New York", "New York", "New York", "New York", "New York", "New York",
                               "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! RestaurantTableViewCell
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    // Mark: Managing Row Selections
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
            nil)
        optionMenu.addAction(cancelAction)

        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message:
                "Sorry, the call feature is not available yet. Please retry later.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler:
                nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)",
            style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            let checkInAction = UIAlertAction(title: "Undo Check in", style: .default, handler:
            {
                (action:UIAlertAction!) -> Void in
                cell?.accessoryType = .none
                self.restaurantIsVisited[indexPath.row] = false
            })
            optionMenu.addAction(checkInAction)
        } else {
            let checkInAction = UIAlertAction(title: "Check in", style: .default, handler:
            {
                (action:UIAlertAction!) -> Void in
                cell?.accessoryType = .checkmark
                self.restaurantIsVisited[indexPath.row] = true
            })
            optionMenu.addAction(checkInAction)
        }
        

        
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    

}

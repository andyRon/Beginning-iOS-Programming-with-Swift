//
//  DiscoverTableViewController.swift
//  FoodPin
//
//  Created by andyron on 2017/8/3.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import CloudKit

class DiscoverTableViewController: UITableViewController {
    
    var restaurants: [CKRecord] = []

    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var imageCache = NSCache<CKRecordID, NSURL>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.hidesWhenStopped = true
        spinner.center = view.center
        tableView.addSubview(spinner)
        spinner.startAnimating()
        
        fetchRecordsFromCloud()
        
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.white
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(fetchRecordsFromCloud), for: UIControlEvents.valueChanged)
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DiscoverTableViewCell
        
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.object(forKey: "name") as? String
        cell.typeLabel.text = restaurant.object(forKey: "type") as? String
        cell.locationLabel.text = restaurant.object(forKey: "location") as? String
        
//        if let image = restaurant.object(forKey: "image") {
//            let imageAsset = image as! CKAsset
//            
//            if let imageData = try? Data.init(contentsOf: imageAsset.fileURL) {
//                cell.imageView?.image = UIImage(data: imageData)
//            }
//        }
//        return cell
        
        // Set the default image
        cell.thumbnailImageView?.image = UIImage(named: "photoalbum")
        
        if let imageFileURL = imageCache.object(forKey: restaurant.recordID) {
            print("从缓存中获取图片")
            if let imageData = try? Data.init(contentsOf: imageFileURL as URL) {
                cell.thumbnailImageView?.image = UIImage(data: imageData)
            }
        } else {
            // Fetch Image from Cloud in background
            let publicDatabase = CKContainer.default().publicCloudDatabase
            let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs:[restaurant.recordID])
            fetchRecordsImageOperation.desiredKeys = ["image",]
            fetchRecordsImageOperation.queuePriority = .veryHigh
            fetchRecordsImageOperation.perRecordCompletionBlock = { (record, recordID, error) -> Void in
                if let error = error {
                    print("Failed to get restaurant image: \(error.localizedDescription)")
                    return
                }
                if let restaurantRecord = record {
                    OperationQueue.main.addOperation() {
                        if let image = restaurantRecord.object(forKey: "image") {
                            let imageAsset = image as! CKAsset
//                            print(imageAsset.fileURL)
                            if let imageData = try? Data.init(contentsOf: imageAsset.fileURL) {
                                cell.thumbnailImageView?.image = UIImage(data: imageData)
                            }
                            // 设置缓存
                            self.imageCache.setObject(imageAsset.fileURL as NSURL, forKey: restaurant.recordID)
                        }
                    }
                }
            }
            publicDatabase.add(fetchRecordsImageOperation)
        }
        
        
        
        return cell
    }

//    func fetchRecordsFromCloud() {
//        
//        let cloudContainer = CKContainer.default()
//        let publicDatabase = cloudContainer.publicCloudDatabase
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
//        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
//            (results, error) -> Void in
//            
//            if error != nil {
//                print(error)
//                return
//            }
//            
//            if let results = results {
//                print("完成Restaurant data的下载")
//                self.restaurants = results
//                
//                OperationQueue.main.addOperation {
//                    self.spinner.stopAnimating()
//                    self.tableView.reloadData()
//                }
//            }
//        })
//    }
    
    
    func fetchRecordsFromCloud() {
        restaurants.removeAll()
        tableView.reloadData()
        
        // Fetch data using Convenience API
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        
        // Create the query operation with the query
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name", "type", "location"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.resultsLimit = 10
        queryOperation.recordFetchedBlock = { (record) -> Void in
            self.restaurants.append(record)
        }
        queryOperation.queryCompletionBlock = { (cursor, error) -> Void in
            if let error = error {
                print("Failed to get data from iCloud - \(error.localizedDescription)")
                return
            }
            print("Successfully retrieve the data from iCloud")
            OperationQueue.main.addOperation {
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
            // 数据加载完，去除下拉刷新的菊花转
            if let refreshControl = self.refreshControl {
                if refreshControl.isRefreshing {
                    refreshControl.endRefreshing()
                }
            }
        }
        // Execute the query
        publicDatabase.add(queryOperation)
    }
}

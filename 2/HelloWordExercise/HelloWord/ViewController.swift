//
//  ViewController.swift
//  HelloWord
//
//  Created by andyron on 2017/2/23.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMessage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "欢迎到我的第一个App", message: "Hello World, I am Andy Ron", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        self.present(alertController, animated: true, completion: nil)
    }

}


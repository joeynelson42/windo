//
//  DetailsTabBarViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class DetailsTabBarController: UITabBarController {
    
    //MARK: Properties
    var members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin"]
    var navColor = UIColor()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        title = "Michael's Party"
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = UIColor.darkPurple()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.purple()
        navigationController?.navigationBar.tintColor = UIColor.darkPurple()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkPurple()]
    }
}

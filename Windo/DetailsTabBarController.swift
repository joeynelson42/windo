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
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        title = "Michael's Party"
        tabBar.tintColor = UIColor.whiteColor()
        tabBar.barTintColor = UIColor.darkPurple()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.purple()
        navigationController?.navigationBar.tintColor = UIColor.darkPurple()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkPurple()]
    }
}
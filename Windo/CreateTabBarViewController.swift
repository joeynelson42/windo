//
//  CreateTabBarViewController.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class CreateTabBarController: UITabBarController {
    
    //MARK: Properties
//    let newEvent = Event()
    var invitees = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        title = "Create Event"
        tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkBlue()]
    }
}
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
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateTabBarController.cancelTapped))
        self.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateTabBarController.doneTapped))
        self.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkBlue()]
    }
    
    func cancelTapped(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func doneTapped(){
        switch selectedIndex {
        case 0:
            selectedIndex = 1
        case 1:
            navigationController?.popViewControllerAnimated(true)
        default:
            return
        }
    }
}
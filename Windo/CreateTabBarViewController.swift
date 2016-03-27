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
    var selectedDates = [NSDate]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        title = "Create Event"
        tabBar.hidden = true
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateTabBarController.cancelTapped))
        self.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateTabBarController.doneTapped))
        self.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
        navigationController?.navigationBar.tintColor = UIColor.darkBlue()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkBlue()]
        navigationController?.navigationBar.translucent = false
    }
    
    func cancelTapped(){
        displayCancelAlert()
    }
    
    func doneTapped(){
        switch selectedIndex {
        case 0:
            selectedIndex = 1
        case 1:
            navigationController?.popViewControllerAnimated(true)
        case 2:
            selectedIndex = 1
        default:
            return
        }
    }
    
    func displayCancelAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Are you sure you want to discard this event?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in}
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Discard", style: .Destructive) { (action) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(destroyAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
//
//  CreateEventViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    //MARK: Properties
    
    var createEventView: CreateEventView!
    var members = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        createEventView = CreateEventView()
        view = createEventView
        addTargets()
        title = "Create Event"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let doneBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doneTapped))
        tabBarController?.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }

    
    func addTargets(){
        let inviteeTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.inviteeTapped))
        createEventView.inviteeCell.addGestureRecognizer(inviteeTap)
    }
    
    func doneTapped(){
        tabBarController?.navigationController?.popViewControllerAnimated(true)
    }
    
    func inviteeTapped(){
        tabBarController?.selectedIndex = 0
    }
}
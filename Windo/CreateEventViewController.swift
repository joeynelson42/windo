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
    
    override func viewWillAppear(animated: Bool) {
        updateInvitees()
    }

    //MARK: Methods
    func addTargets(){
        let inviteeTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.inviteeTapped))
        createEventView.inviteeCell.addGestureRecognizer(inviteeTap)
    }
    
    func updateInvitees(){
        
        if(tabBarController as! CreateTabBarController).invitees.count < 1 {
            createEventView.inviteeLabel.text = createEventView.inviteePlaceholderText
            return
        }
        
        for (index, name) in (tabBarController as! CreateTabBarController).invitees.enumerate() {
            if index == 0 {
                createEventView.inviteeLabel.text = name
            }
            else{
                let currentText = createEventView.inviteeLabel.text!
                createEventView.inviteeLabel.text! = "\(currentText), \(name)"
            }
        }
    }
    
    func doneTapped(){
        tabBarController?.navigationController?.popViewControllerAnimated(true)
    }
    
    func inviteeTapped(){
        tabBarController?.selectedIndex = 0
    }
}
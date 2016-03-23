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
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
        self.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
//        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doneTapped))
//        self.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        
        
    }
    
    func addTargets(){
        let inviteeTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.inviteeTapped))
        createEventView.inviteeCell.addGestureRecognizer(inviteeTap)
    }
    
    func cancelTapped(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func doneTapped(){
//        createEventView.inviteeTableView.hidden = true
    }
    
    func inviteeTapped(){
        let inviteVC = InviteViewController()
        navigationController?.pushViewController(inviteVC, animated: false)
    }
}
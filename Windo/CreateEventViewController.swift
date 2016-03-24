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
    var initialStates = [CGFloat]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        createEventView = CreateEventView()
        view = createEventView
        addTargets()
        title = "Create Event"
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        
        createEventView.calendarContainer.dragView.addGestureRecognizer(drag)
        createEventView.calendarContainer.dragView.addGestureRecognizer(tap)
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        initialStates.removeAll()
        let days = createEventView.calendarContainer.days
        for day in days {
            initialStates.append(day.selectedBackground.alpha)
        }
    }
    
    func handleCalendarGesture(gesture: UIGestureRecognizer){
        let days = createEventView.calendarContainer.days
        
        for (index,day) in days.enumerate() {
            if day.frame.contains(gesture.locationInView(createEventView.calendarContainer)){
                if (day.selectedBackground.alpha == initialStates[index]){
                    day.tapped()
                }
            }
        }
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
//
//  CreateEventViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import CoreData

class CreateEventViewController: UIViewController {
    
    //MARK: Properties
    var createTabBar: CreateTabBarController!
    var createEventView: CreateEventView!
    var members = [String]()
    var initialStates = [CGFloat]()
    var selectedTimes = [NSDate]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedObjectContext = appDelegate.managedObjectContext
//        
//        let entityDescription = NSEntityDescription.entityForName("Event", inManagedObjectContext: managedObjectContext)
//        let newEvent = Event(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        createTabBar = (tabBarController as! CreateTabBarController)
        createEventView = CreateEventView()
        view = createEventView
        addTargets()
        title = "Create Event"
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        
        createEventView.calendarContainer.dragView.addGestureRecognizer(drag)
        createEventView.calendarContainer.dragView.addGestureRecognizer(tap)
        createEventView.calendarContainer.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
        createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        updateInvitees()
    }

    //MARK: Methods
    func addTargets(){
        let inviteeTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.inviteeTapped))
        createEventView.inviteeCell.addGestureRecognizer(inviteeTap)
        
        createEventView.finishButton.addTarget(self, action: #selector(CreateEventViewController.handleFinish), forControlEvents: .TouchUpInside)
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
        if createTabBar.invitees.count < 1 {
            createEventView.inviteeLabel.text = createEventView.inviteePlaceholderText
            return
        }
        
        for (index, name) in createTabBar.invitees.enumerate() {
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
        createTabBar.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancelTapped(){
        createTabBar.displayCancelAlert()
    }
    
    func inviteeTapped(){
        tabBarController?.selectedIndex = 0
    }
    
    func handleFinish(){
        let dates = createEventView.calendarContainer.selectedDays
        (createTabBar.viewControllers![2] as! WindoTimeViewController).dates = dates
        createTabBar.selectedIndex = 2
    }
}

extension CreateEventViewController: WindoCalendarDelegate {
    
    func daysSelectedDidChange(dates: [NSDate]) {
        createTabBar.selectedDates = dates
    }
}
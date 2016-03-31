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
        
        createTabBar.title = "Create Event"
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
        createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.nextTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        updateInvitees()
    }

    //MARK: Methods
    func addTargets(){
        let inviteeTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.inviteeTapped))
        createEventView.inviteeCell.addGestureRecognizer(inviteeTap)
        
//        createEventView.setAvailabilityButton.addTarget(self, action: #selector(CreateEventViewController.handleSetAvailability), forControlEvents: .TouchUpInside)
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
    
    func nextTapped(){
        let dates = createEventView.calendarContainer.selectedDays
        
        if dates.count > 0 {
            createTabBar.title = "Specify Times"
            (createTabBar.viewControllers![2] as! WindoTimeViewController).dates = dates
            createTabBar.selectedIndex = 2
        }
        else {
            noDaysAlert()
        }
    }
    
    func cancelTapped(){
        createTabBar.displayCancelAlert()
    }
    
    func inviteeTapped(){
        (createTabBar.viewControllers![0] as! InviteViewController).state = InviteState.AddingInvites
        tabBarController?.selectedIndex = 0
    }
    
//    func handleSetAvailability(){
//        let dates = createEventView.calendarContainer.selectedDays
//        (createTabBar.viewControllers![2] as! WindoTimeViewController).dates = dates
//        createTabBar.selectedIndex = 2
//    }
    
    func noDaysAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Select some days on the calendar first!", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in}
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

extension CreateEventViewController: WindoCalendarDelegate {
    
    func daysSelectedDidChange(dates: [NSDate]) {
        createTabBar.selectedDates = dates
    }
}
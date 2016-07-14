//
//  CreateTabBarViewController.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import CoreLocation

// ViewController 1: InviteViewController
// ViewController 2: CreatEventViewController
// ViewController 3: WindoTimeViewController

class CreateTabBarController: UITabBarController {
    
    //MARK: Properties
    var eventName = ""
    var eventLocation: CLLocation!
    var invitees = [Invitee]()
    var selectedDates = [NSDate]()
    var selectedTimes = [NSDate]()
    
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
    
    func finalizeEvent() {
        let userInvitee = Invitee(number: UserManager.sharedManager.user!.phoneNumber, firstName: UserManager.sharedManager.user!.firstName, lastName: UserManager.sharedManager.user!.lastName)
        invitees.append(userInvitee)
        
        let eventID = String.randomAlphaNumericString(15)
        let windoID = String.randomAlphaNumericString(15)
        
        let eventWindo = Windo(id: windoID, ownerID: userInvitee.phoneNumber, eventID: eventID, times: selectedTimes, dateCreated: NSDate())
        
        var eventMembers = [String]()
        for invitee in invitees {
            eventMembers.append(invitee.phoneNumber)
        }
        
        let _ = Event(id: eventID, name: eventName, location: eventLocation, members: eventMembers, eventCreator: userInvitee.phoneNumber, dateCreated: NSDate(), eventWindo: eventWindo.ID, memberSubmissions: [], possibleTimes: [])
        
//        CloudManager.sharedManager save event!
    }
    
    // MARK: Time Management
    func addAllDaysTime(date: NSDate) {
        var newTime = date
        if selectedTimes.contains(newTime){
            
            guard let index = selectedTimes.indexOf(newTime) else { return }
            selectedTimes.removeAtIndex(index)
            
            for day in selectedDates {
                newTime = createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: newTime.hour())
                
                if selectedTimes.contains(newTime){
                    guard let index = selectedTimes.indexOf(newTime) else { return }
                    selectedTimes.removeAtIndex(index)
                }
            }
        }
        else {
            selectedTimes.append(newTime)
            for day in selectedDates {
                newTime = createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: newTime.hour())
                if !selectedTimes.contains(newTime){
                    selectedTimes.append(newTime)
                }
            }
        }
    }
    
    func datesChangedUpdateTimes() {
        for time in selectedTimes {
            var keepTime = false
            for date in selectedDates {
                if time.fullDate() == date.fullDate() {
                    keepTime = true
                }
            }
            
            if !keepTime {
                guard let index = selectedTimes.indexOf(time) else { return }
                selectedTimes.removeAtIndex(index)
            }
        }
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = 0
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
}
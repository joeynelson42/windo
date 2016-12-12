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
    var selectedDates = [Date]()
    var selectedTimes = [Date]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        title = "Create Event"
        tabBar.isHidden = true
        
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateTabBarController.cancelTapped))
        self.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateTabBarController.doneTapped))
        self.navigationItem.setRightBarButton(doneBarButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
        navigationController?.navigationBar.tintColor = UIColor.extraDarkBlue()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.extraDarkBlue()]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func cancelTapped(){
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func doneTapped(){
        switch selectedIndex {
        case 0:
            
            if invitees.count == 0 {
                displayNoInviteesAlert()
            } else if selectedDates.count == 0 {
                displayNoDaysAlert()
            } else {
                selectedIndex = 1
                title = "Specify Times"
            }
        case 1:
            let _ = navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
    
    func displayNoInviteesAlert(){
        let alertController = UIAlertController(title: "Invite friends", message: "It's not a party without people.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action) in}
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func displayNoDaysAlert(){
        let alertController = UIAlertController(title: "Select days", message: "Select some days on the calendar first.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action) in}
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func displayCancelAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Are you sure you want to discard this event?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Discard", style: .destructive) { (action) in
            let _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(destroyAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func finalizeEvent() {
        let userInvitee = Invitee(number: UserManager.sharedManager.user!.phoneNumber, firstName: UserManager.sharedManager.user!.firstName, lastName: UserManager.sharedManager.user!.lastName)
        invitees.append(userInvitee)
        
        let eventID = String.randomAlphaNumericString(15)
        let windoID = String.randomAlphaNumericString(15)
        
        let eventWindo = Windo(id: windoID, ownerID: userInvitee.phoneNumber, eventID: eventID, times: selectedTimes, dateCreated: Date())
        
        var eventMembers = [String]()
        for invitee in invitees {
            eventMembers.append(invitee.phoneNumber)
        }
        
        let _ = Event(id: eventID, name: eventName, location: eventLocation, members: eventMembers, eventCreator: userInvitee.phoneNumber, dateCreated: Date(), eventWindo: eventWindo.ID, memberSubmissions: [], possibleTimes: [], timeZone: "")
        
//        CloudManager.sharedManager save event!
    }
    
    // MARK: Time Management
    func addAllDaysTime(_ date: Date) {
        var newTime = date
        if selectedTimes.contains(newTime){
            
            guard let index = selectedTimes.index(of: newTime) else { return }
            selectedTimes.remove(at: index)
            
            for day in selectedDates {
                newTime = Date.createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: newTime.hour(), minuteNumber: newTime.minute())
                
                if selectedTimes.contains(newTime){
                    guard let index = selectedTimes.index(of: newTime) else { return }
                    selectedTimes.remove(at: index)
                }
            }
        }
        else {
            selectedTimes.append(newTime)
            for day in selectedDates {
                newTime = Date.createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: newTime.hour(), minuteNumber: newTime.minute())
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
                guard let index = selectedTimes.index(of: time) else { return }
                selectedTimes.remove(at: index)
            }
        }
    }
}

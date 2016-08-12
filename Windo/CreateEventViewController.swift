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
    
    var filteredInvitees = [Invitee]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        createTabBar = (tabBarController as! CreateTabBarController)
        createEventView = CreateEventView()
        view = createEventView
        title = "Create Event"
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        
        createEventView.calendarContainer.dragView.addGestureRecognizer(drag)
        createEventView.calendarContainer.dragView.addGestureRecognizer(tap)
        createEventView.calendarContainer.delegate = self
        
        createEventView.inviteeTableView.delegate = self
        createEventView.inviteeTableView.dataSource = self
        
        createEventView.tokenBar.delegate = self
        createEventView.tokenBar.dataSource = self
        
        if ContactManager.sharedManager.contacts.count > 0 {
            filteredInvitees = ContactManager.sharedManager.contacts
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setNavigationButtons(false)
    }

    //MARK: Methods
    
    func setNavigationButtons(tableShowing: Bool) {
        if !tableShowing {
            createTabBar.title = "Create Event"
            
            let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.nextTapped))
            createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        } else {
            createTabBar.title = "Invite Friends"
            
            let cancelBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doNothing))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doneTapped))
            createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        }
    }
    
    func handleCalendarGesture(gesture: UIGestureRecognizer){
        let days = createEventView.calendarContainer.days
        if initialStates.isEmpty {
            for day in days {
                initialStates.append(day.selectedBackground.alpha)
            }
        }
        
        for (index,day) in days.enumerate() {
            if day.frame.contains(gesture.locationInView(createEventView.calendarContainer)){
                if (day.selectedBackground.alpha == initialStates[index]){
                    day.tapped()
                }
            }
        }
        
        if gesture.state == .Ended {
            initialStates.removeAll()
        }
        
        createTabBar.datesChangedUpdateTimes()
    }
    
    func nextTapped(){
        createTabBar.doneTapped()
    }
    
    func cancelTapped(){
        createTabBar.displayCancelAlert()
    }
    
    func doneTapped() {
        setNavigationButtons(false)
        
        if createTabBar.invitees.count == 0 {
            createEventView.hideTableView("", numberOfInvitees: 0)
        } else {
            createEventView.hideTableView(createTabBar.invitees[0].firstName, numberOfInvitees: createTabBar.invitees.count)
        }
    }
    
    func doNothing(){}
}

extension CreateEventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvitees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteeCell") as! InviteeCell
        
        let invitee = filteredInvitees[indexPath.row]
            
        cell.nameLabel.text = "\(invitee.fullName)"
//        cell.subtitleLabel.text = "\(invitee.phoneNumber)"
        cell.initials.name = invitee.fullName
        
//        print("\(invitee.fullName) == \(invitee.fullName.getInitials())")
        
        if createTabBar.invitees.contains(invitee){
            cell.checkmarkImageView.alpha = 1.0
            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            cell.infoButton.alpha = 0.0
            cell.infoButton.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        }
        else{
            cell.infoButton.alpha = 1.0
            cell.infoButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            cell.checkmarkImageView.alpha = 0.0
            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        }
        
        cell.infoGestureRecognizer.addTarget(self, action: #selector(CreateEventViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteeCell
        let friend = filteredInvitees[indexPath.row]
        
        if createTabBar.invitees.contains(friend){
            let index = createTabBar.invitees.indexOf(friend)
            createTabBar.invitees.removeAtIndex(index!)
        } else{
            createTabBar.invitees.append(friend)
        }
        
        cell.animateChange()
        updateSearchResultsForSearchController("")
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        createEventView.tokenBar.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("inviteeHeaderCell") as! InviteeHeaderCell
        
        let bgColor = UIColor.darkBlue()
        var label = ""
        switch(section){
        case 0:
            label = "Recently invited"
        case 1:
            label = "All Contacts"
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        header.contentView.backgroundColor = bgColor
        return header
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func openUserProfile(sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
//        profileVC.user = allFriends[0]
        profileVC.color = ThemeColor.Blue
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension CreateEventViewController: VENTokenFieldDelegate, VENTokenFieldDataSource {
    func numberOfTokensInTokenField(tokenField: VENTokenField) -> UInt {
        return  UInt(createTabBar.invitees.count)
    }
    
    func tokenField(tokenField: VENTokenField, titleForTokenAtIndex index: UInt) -> String {
        return  createTabBar.invitees[Int(index)].firstName
    }
    
    func tokenField(tokenField: VENTokenField, didEnterText text: String) {
        
    }
    
    func tokenField(tokenField: VENTokenField, didDeleteTokenAtIndex index: UInt) {
        createTabBar.invitees.removeAtIndex(Int(index))
        createEventView.tokenBar.reloadData()
        createEventView.inviteeTableView.reloadData()
    }
    
    func tokenField(tokenField: VENTokenField, didChangeText text: String?) {
        if let searchText = text {
            updateSearchResultsForSearchController(searchText)
        }
    }
    
    func tokenFieldDidBeginEditing(tokenField: VENTokenField) {
        if createEventView.inviteeTableView.hidden == true {
            createEventView.showTableView()
            createEventView.bringSubviewToFront(createEventView.inviteeTableView)
            setNavigationButtons(true)
        }
    }
    
    func tokenField(tokenField: VENTokenField, didChangeContentHeight height: CGFloat) {
        var cellHeight = height
        if height < createEventView.cellSize {
            cellHeight = createEventView.cellSize
        }
        
        createEventView.tokenBar.addConstraints(
            Constraint.tt.of(createEventView),
            Constraint.cxcx.of(createEventView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellHeight)
        )
        
        createEventView.layoutIfNeeded()
    }
    
    func updateSearchResultsForSearchController(searchString: String) {
        defer {createEventView.inviteeTableView.reloadData()}
        
        if (searchString == "") {
            filteredInvitees = ContactManager.sharedManager.contacts
            return
        }
        
        filteredInvitees.removeAll(keepCapacity: false)
        filteredInvitees = ContactManager.sharedManager.contacts.filter() { $0.fullName.containsString(searchString) }
    }
}

extension CreateEventViewController: WindoCalendarDelegate {
    
    func daysSelectedDidChange(dates: [NSDate]) {
        createTabBar.selectedDates = dates
    }
}
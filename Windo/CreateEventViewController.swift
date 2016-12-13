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
    var selectedTimes = [Date]()
    
    var filteredInvitees = [Invitee]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        createTabBar = (tabBarController as! CreateTabBarController)
        createEventView = CreateEventView()
        view = createEventView
        title = "Create Event"
        
        createEventView.inviteeTableView.delegate = self
        createEventView.inviteeTableView.dataSource = self
        
        createEventView.tokenBar.delegate = self
        createEventView.tokenBar.dataSource = self
        
        createEventView.calendar.dataSource = self
        createEventView.calendar.delegate = self
        
        if ContactManager.sharedManager.contacts.count > 0 {
            filteredInvitees = ContactManager.sharedManager.contacts
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNavigationButtons(false)
    }

    //MARK: Methods
    
    func setNavigationButtons(_ tableShowing: Bool) {
        if !tableShowing {
            createTabBar.title = "Create Event"
            
            let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
            createTabBar.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEventViewController.nextTapped))
            createTabBar.navigationItem.setRightBarButton(doneBarButton, animated: true)
        } else {
            createTabBar.title = "Invite Friends"
            
            let cancelBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEventViewController.doNothing))
            createTabBar.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEventViewController.doneTapped))
            createTabBar.navigationItem.setRightBarButton(doneBarButton, animated: true)
        }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvitees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteeCell") as! InviteeCell
        
        let invitee = filteredInvitees[(indexPath as NSIndexPath).row]
            
        cell.nameLabel.text = "\(invitee.fullName)"
//        cell.subtitleLabel.text = "\(invitee.phoneNumber)"
        cell.initials.name = invitee.fullName
        
//        print("\(invitee.fullName) == \(invitee.fullName.getInitials())")
        
        if createTabBar.invitees.contains(invitee){
            cell.checkmarkImageView.alpha = 1.0
            cell.checkmarkImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            cell.infoButton.alpha = 0.0
            cell.infoButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
        else{
            cell.infoButton.alpha = 1.0
            cell.infoButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            cell.checkmarkImageView.alpha = 0.0
            cell.checkmarkImageView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
        
        cell.infoGestureRecognizer.addTarget(self, action: #selector(CreateEventViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! InviteeCell
        let friend = filteredInvitees[(indexPath as NSIndexPath).row]
        
        if createTabBar.invitees.contains(friend){
            let index = createTabBar.invitees.index(of: friend)
            createTabBar.invitees.remove(at: index!)
        } else{
            createTabBar.invitees.append(friend)
        }
        
        cell.animateChange()
        updateSearchResultsForSearchController("")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        createEventView.tokenBar.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "inviteeHeaderCell") as! InviteeHeaderCell
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func openUserProfile(_ sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
//        profileVC.user = allFriends[0]
        profileVC.color = ThemeColor.blue
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension CreateEventViewController: VENTokenFieldDelegate, VENTokenFieldDataSource {
    func numberOfTokens(in tokenField: VENTokenField) -> UInt {
        return  UInt(createTabBar.invitees.count)
    }
    
    func tokenField(_ tokenField: VENTokenField, titleForTokenAt index: UInt) -> String {
        return  createTabBar.invitees[Int(index)].firstName
    }
    
    func tokenField(_ tokenField: VENTokenField, didEnterText text: String) {
        
    }
    
    func tokenField(_ tokenField: VENTokenField, didDeleteTokenAt index: UInt) {
        createTabBar.invitees.remove(at: Int(index))
        createEventView.tokenBar.reloadData()
        createEventView.inviteeTableView.reloadData()
    }
    
    func tokenField(_ tokenField: VENTokenField, didChangeText text: String?) {
        if let searchText = text {
            updateSearchResultsForSearchController(searchText)
        }
    }
    
    func tokenFieldDidBeginEditing(_ tokenField: VENTokenField) {
        if createEventView.inviteeTableView.isHidden == true {
            createEventView.showTableView()
            createEventView.bringSubview(toFront: createEventView.inviteeTableView)
            setNavigationButtons(true)
        }
    }
    
    func tokenField(_ tokenField: VENTokenField, didChangeContentHeight height: CGFloat) {
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
    
    func updateSearchResultsForSearchController(_ searchString: String) {
        defer {createEventView.inviteeTableView.reloadData()}
        
        if (searchString == "") {
            filteredInvitees = ContactManager.sharedManager.contacts
            return
        }
        
        filteredInvitees.removeAll(keepingCapacity: false)
        filteredInvitees = ContactManager.sharedManager.contacts.filter() { $0.fullName.contains(searchString) }
    }
}

extension CreateEventViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func daysSelectedDidChange(_ dates: [Date]) {
        createTabBar.selectedDates = dates
    }
   
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let calendarCell = cell as? CalendarCell else { return }
        calendarCell.updateWithSelectedState()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print((createEventView.calendar.calendarWeekdayView.frame.height + createEventView.calendar.calendarHeaderView.frame.height) / screenHeight)
        
        createTabBar.selectedDates.append(date)
        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else { return }
        cell.updateWithSelectedState(animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let index = createTabBar.selectedDates.index(of: date) else { return }
        createTabBar.selectedDates.remove(at: index)
        guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else { return }
        cell.updateWithSelectedState(animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current;
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.createEventView.calendar.frame.size.height = bounds.height
    }
}

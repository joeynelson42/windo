//
//  InviteViewController.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum InviteState{
    case FirstInvite
    case AddingInvites
}

class InviteViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    var state: InviteState = .FirstInvite
    var createTabBar: CreateTabBarController!
    var inviteView = InviteView()
    var filteredInvitees = [UserProfile]()
    let userProfile = UserManager.userProfile
    let allFriends = UserManager.userProfile.friends
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar = (tabBarController as! CreateTabBarController)
        view = inviteView
        
        inviteView.inviteeTableView.delegate = self
        inviteView.inviteeTableView.dataSource = self
        
        inviteView.searchBar.delegate = self
    
        
        filteredInvitees = userProfile.friends
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        createTabBar.title = "Create Event"
        
        if state == .FirstInvite {
            let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.cancelTapped))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        }
        else {
            let cancelBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.doNothing))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        }
        
        
        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    func doneTapped(){
        createTabBar.selectedIndex = 1
    }
    
    func cancelTapped(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func doNothing(){
        
    }
    
    func updateInvitees(){
        
        if createTabBar.invitees.count < 1 {
            inviteView.inviteeLabel.text = inviteView.inviteePlaceholderText
            return
        }
        
        for (index, name) in createTabBar.invitees.enumerate() {
            var fullNameArr = name.characters.split{$0 == " "}.map(String.init)
            var firstName = fullNameArr[0]
            
            if index == 0 {
                inviteView.inviteeLabel.text = firstName
            }
            else if createTabBar.invitees.count > 3{
                fullNameArr = createTabBar.invitees[0].characters.split{$0 == " "}.map(String.init)
                firstName = fullNameArr[0]
                fullNameArr = createTabBar.invitees[1].characters.split{$0 == " "}.map(String.init)
                let secondName = fullNameArr[0]
                inviteView.inviteeLabel.text! = "\(firstName), \(secondName), and \(createTabBar.invitees.count - 2) others"
                break
            }
            else{
                let currentText = inviteView.inviteeLabel.text!
                inviteView.inviteeLabel.text! = "\(currentText), \(firstName)"
            }
        }
    }
}

extension InviteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvitees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteeCell") as! InviteeCell
        let friend = filteredInvitees[indexPath.row]
        
        cell.nameLabel.text = friend.fullName()
        cell.userHandleLabel.text = "@\(friend.fullName().lowercaseString)"
        cell.userHandleLabel.text = cell.userHandleLabel.text?.stringByReplacingOccurrencesOfString(" ", withString: "-")
        cell.initialsLabel.text = friend.fullName().getInitials()
        
        if createTabBar.invitees.contains(friend.fullName()){
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
        
        cell.infoGestureRecognizer.addTarget(self, action: #selector(InviteViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteeCell
        let friend = filteredInvitees[indexPath.row]
        
        if createTabBar.invitees.contains(friend.fullName()){
            let index = createTabBar.invitees.indexOf(friend.fullName())
            createTabBar.invitees.removeAtIndex(index!)
        } else{
            createTabBar.invitees.append(cell.nameLabel.text!)
        }

        cell.animateChange()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        updateInvitees()
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        inviteView.inviteeTableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        inviteView.inviteeTableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResultsForSearchController(searchText)
    }
    
    func updateSearchResultsForSearchController(searchString: String) {
        defer {inviteView.inviteeTableView.reloadData()}
        
        if (searchString == "") {
            filteredInvitees = allFriends
            return
        }
        
        filteredInvitees.removeAll(keepCapacity: false)
        filteredInvitees = allFriends.filter() { $0.fullName().containsString(searchString) }
    }
    
    func getInitials(name: String) -> String{
        let firstInitial = "\(name[name.startIndex.advancedBy(0)])"
        
        guard let index = name.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(name[name.startIndex.advancedBy(name.startIndex.distanceTo(index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func openUserProfile(sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
        profileVC.color = ThemeColor.Blue
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
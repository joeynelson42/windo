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

class InviteViewController: UIViewController {
    
    //MARK: Properties
    
    var state: InviteState = .FirstInvite
    var createTabBar: CreateTabBarController!
    var inviteView = InviteView()
    var members = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar = (tabBarController as! CreateTabBarController)
        view = inviteView
        
        inviteView.inviteeTableView.delegate = self
        inviteView.inviteeTableView.dataSource = self
        
        //Dummy data
        members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin", "Paul Turner", "Vladi Falk", "Tucker Turner", "Tyler Alden", "Kara Leigh Alden"]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        createTabBar.title = "Add People"
        
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
            if index == 0 {
                inviteView.inviteeLabel.text = name
            }
            else{
                let currentText = inviteView.inviteeLabel.text!
                inviteView.inviteeLabel.text! = "\(currentText), \(name)"
            }
        }
    }
}

extension InviteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteeCell") as! InviteeCell
        
        cell.nameLabel.text = members[indexPath.row]
        cell.userHandleLabel.text = "@\(members[indexPath.row].lowercaseString)"
        cell.userHandleLabel.text = cell.userHandleLabel.text?.stringByReplacingOccurrencesOfString(" ", withString: "-")
        cell.initialsLabel.text = getInitials(members[indexPath.row])
        
        if createTabBar.invitees.contains(members[indexPath.row]){
            cell.checkmarkImageView.hidden = false
            cell.infoButton.hidden = true
        }
        else{
            cell.checkmarkImageView.hidden = true
            cell.infoButton.hidden = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteeCell
        
        if createTabBar.invitees.contains(members[indexPath.row]){
            let index = createTabBar.invitees.indexOf(members[indexPath.row])
            createTabBar.invitees.removeAtIndex(index!)
            cell.checkmarkImageView.hidden = true
            cell.infoButton.hidden = false
        }
        else{
            createTabBar.invitees.append(cell.nameLabel.text!)
            cell.checkmarkImageView.hidden = false
            cell.infoButton.hidden = true
        }

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
            //            bgColor = UIColor.lightTeal()
        case 1:
            label = "All Contacts"
            //            bgColor = UIColor.teal()
            //        case 2:
            //            label = "Past"
            //            bgColor = UIColor.darkTeal()
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        header.contentView.backgroundColor = bgColor
        return header
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
}
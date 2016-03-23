//
//  InviteViewController.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    //MARK: Properties
    
    var inviteView = InviteView()
    var members = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = inviteView
        
        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.doneTapped))
        self.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        
        inviteView.inviteeTableView.delegate = self
        inviteView.inviteeTableView.dataSource = self
        
        //Dummy data
        members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin", "Paul Turner", "Vladi Falk", "Tucker Turner", "Tyler Alden", "Kara Leigh Alden"]
    }
    
    func doneTapped(){
        navigationController?.popViewControllerAnimated(false)
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
        cell.initialsLabel.text = getInitials(members[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
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
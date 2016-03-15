//
//  EventDetailsViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit


class EventDetailsViewController: UIViewController {
    
    //MARK: Properties
    
    var detailsView: EventDetailsView!
    var members = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        detailsView = EventDetailsView()
        view.backgroundColor = UIColor.purple()
        view = detailsView
        detailsView.memberTableView.delegate = self
        detailsView.memberTableView.dataSource = self
        
        members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin", "Paul Turner", "Vladi Falk"]
        detailsView.addMemberButton.addTarget(self, action: "addMemberTapped", forControlEvents: .TouchUpInside)
        
    }
    
    func addMemberTapped(){
        let response5 = ResponseCircleView()
        response5.initials.text = "TT"
        members.append("Tucker Turner")
        detailsView.memberTableView.reloadData()
        
        detailsView.respondedStackView.addArrangedSubview(response5)
        detailsView.respondedStackView.constrainUsing(constraints: [
            Constraint.tt : (of: self.detailsView, offset: 82),
            Constraint.cxcx : (of: self.detailsView, offset: 0),
            Constraint.w : (of: nil, offset: 44*5),
            Constraint.h : (of: nil, offset: 40)])
        detailsView.respondedStackView.spacing = 5
    }
}

extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell") as! GroupMemberCell
        
        cell.nameLabel.text = members[indexPath.row]
        cell.initialsLabel.text = getInitials(members[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
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
}

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
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.purple()
        navigationController?.navigationBar.tintColor = UIColor.darkPurple()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkPurple()]
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, animations: { Void in
            self.detailsView.alpha = 1.0
        })
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

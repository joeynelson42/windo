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
    var responseNeeded = false
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        detailsView = EventDetailsView()
        view.backgroundColor = UIColor.purple()
        view = detailsView
        detailsView.memberTableView.delegate = self
        detailsView.memberTableView.dataSource = self
        
        members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin", "Paul Turner", "Vladi Falk"]
        detailsView.addMemberButton.addTarget(self, action: #selector(EventDetailsViewController.addMemberTapped), for: .touchUpInside)
        detailsView.anytimeWorks.addTarget(self, action: #selector(EventDetailsViewController.dismissResponseNeeded), for: .touchUpInside)
        
        if responseNeeded{
            showResponseOptions()
        } else {
            hideResponseOptions()
        }

    }
    
    func addMemberTapped(){
        let response5 = ResponseCircleView()
        response5.initials.text = "TT"
        members.append("Tucker Turner")
        detailsView.memberTableView.reloadData()
        
        detailsView.respondedStackView.addArrangedSubview(response5)
        detailsView.respondedStackView.addConstraints(
            Constraint.tt.of(detailsView, offset: 18),
            Constraint.cxcx.of(detailsView),
            Constraint.w.of(CGFloat(44 * 5)),
            Constraint.h.of(40)
        )
        detailsView.respondedStackView.spacing = 5
    }
    
    func dismissResponseNeeded() {
        hideResponseOptions()
    }
    
    func showResponseOptions(){
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.white
        detailsView.backgroundColor = UIColor.white
        
        detailsView.separatingLine.isHidden = true
        detailsView.locationTitleLabel.isHidden = true
        detailsView.locationLabel.isHidden = true
        detailsView.dateTimeTitleLabel.isHidden = true
        detailsView.dateTimeLabel.isHidden = true
        
        detailsView.anytimeWorks.isHidden = false
        detailsView.submitTimes.isHidden = false
        detailsView.responseLabel.isHidden = false
        
        detailsView.blurView.isHidden = false
        
        tabBarController?.tabBar.isHidden = true
    }
    
    func hideResponseOptions(){
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.purple()
        detailsView.backgroundColor = UIColor.lightPurple()
        
        detailsView.separatingLine.isHidden = false
        detailsView.locationTitleLabel.isHidden = false
        detailsView.locationLabel.isHidden = false
        detailsView.dateTimeTitleLabel.isHidden = false
        detailsView.dateTimeLabel.isHidden = false
        
        detailsView.anytimeWorks.isHidden = true
        detailsView.submitTimes.isHidden = true
        detailsView.responseLabel.isHidden = true
        
        detailsView.blurView.isHidden = true
        
        tabBarController?.tabBar.isHidden = false
    }
}

extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! GroupMemberCell
        
        cell.nameLabel.text = members[(indexPath as NSIndexPath).row]
        cell.initialsLabel.text = getInitials(members[(indexPath as NSIndexPath).row])
        cell.infoGestureRecognizer.addTarget(self, action: #selector(EventDetailsViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func getInitials(_ name: String) -> String{
        let firstInitial = "\(name[name.characters.index(name.startIndex, offsetBy: 0)])"
        
        guard let index = name.characters.index(of: " ") else {
            return firstInitial.uppercased()
        }
        
        let secondInitial = "\(name[name.characters.index(name.startIndex, offsetBy: name.characters.distance(from: name.startIndex, to: index) + 1)])"
        
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercased()
    }
    
    func openUserProfile(_ sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
        profileVC.color = ThemeColor.purple
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

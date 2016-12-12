//
//  HomeViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import Contacts

class HomeViewController: UIViewController{
    
    //MARK: Properties
    
    var homeView = HomeView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view = homeView
        title = "Events"
                
        let sideMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        sideMenuButton.setImage(UIImage(named: "HamburgerIcon"), for: UIControlState())
        sideMenuButton.addTarget(self, action: #selector(HomeViewController.openProfile), for: .touchUpInside)
        let sideMenuBarButton = UIBarButtonItem(customView: sideMenuButton)
        self.navigationItem.setLeftBarButton(sideMenuBarButton, animated: true)
        
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        addEventButton.setImage(UIImage(named: "AddEventButton"), for: UIControlState())
        addEventButton.addTarget(self, action: #selector(HomeViewController.createNewEvent), for: .touchUpInside)
        let addEventBarButton = UIBarButtonItem(customView: addEventButton)
        self.navigationItem.setRightBarButton(addEventBarButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightTeal()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.mikeBlue()]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        ContactManager.sharedManager.sync { (success) -> () in
//
//        }
    }
    
    func openProfile() {
        let settingsVC = SettingsViewController()
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction  = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        homeView.window?.layer.add(transition, forKey: nil)
        
        self.present(settingsVC, animated: false, completion: nil)
    }
    
    func createNewEvent() {
        let createTabVC = CreateTabBarController()
        let vc1 = CreateEventViewController()
        let vc2 = TimeSelectViewController()
        
        let controllers = [vc1, vc2]
        
        vc1.tabBarItem = UITabBarItem(
            title: "Create",
            image: UIImage(named: "HomeIcon"),
            tag: 1)
        
        vc2.tabBarItem = UITabBarItem(
            title: "WindoSelect",
            image: UIImage(named: "HomeIcon"),
            tag: 2)
        
        createTabVC.viewControllers = controllers
        createTabVC.selectedIndex = 0
        navigationController?.pushViewController(createTabVC, animated: true)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView(){
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = self
    }
    
    //MARK: Cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        cell.backgroundColor = UIColor.teal()
        cell.titleLabel.text = "Michael's Party"
        cell.locationLabel.text = "The Yellow Door House"
        cell.eventStatus.text = "You need to respond!"
        cell.eventStatus.textColor = UIColor.white
        cell.selectionStyle = .none
        cell.notificationDot.isHidden = true

        switch((indexPath as NSIndexPath).section){
        case 0:
            cell.backgroundColor = UIColor.lightTeal()
            cell.titleLabel.text = "BFA Dinner"
            cell.eventStatus.text = "April 17, 2016 4:00pm"
        case 1:
            cell.backgroundColor = UIColor.teal()
            cell.titleLabel.text = "St. George Trip"
            cell.notificationDot.isHidden = false
        case 2:
            cell.backgroundColor = UIColor.darkTeal()
            cell.eventStatus.text = "February 4, 2016 8:00pm"
            cell.eventStatus.textColor = UIColor.mikeBlue()
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsTabBarController()
        let vc1 = EventMessagesViewController()
        let vc2 = EventDetailsViewController()
        let vc3 = EventResultsViewController()
        let controllers = [vc1, vc2, vc3]
        
        vc1.tabBarItem = UITabBarItem(
            title: "Messages",
            image: UIImage(named: "MessageIcon"),
            tag: 1)
        
        vc2.tabBarItem = UITabBarItem(
            title: "Event Info",
            image: UIImage(named: "HomeIcon"),
            tag: 2)
        
        vc3.tabBarItem = UITabBarItem(
            title: "Results",
            image: UIImage(named: "ResultsIcon"),
            tag: 3)
        
        detailsVC.viewControllers = controllers
        detailsVC.selectedIndex = 1
        navigationController?.pushViewController(detailsVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Header
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "eventHeaderCell") as! EventHeaderCell
        
        var bgColor = UIColor()
        var label = ""
        switch(section){
        case 0:
            label = "Upcoming"
            bgColor = UIColor.lightTeal()
        case 1:
            label = "Pending"
            bgColor = UIColor.teal()
        case 2:
            label = "Past"
            bgColor = UIColor.darkTeal()
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        header.contentView.backgroundColor = bgColor
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}

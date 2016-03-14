//
//  HomeViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class HomeViewController: CenterViewController{
    
    //MARK: Properties
    
    var homeView = HomeView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.view = homeView
        title = "Events"
        view.backgroundColor = UIColor.teal()
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView(){
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! EventCell
        cell.backgroundColor = UIColor.teal()
        cell.titleLabel.text = "Michael's Party"
        cell.locationLabel.text = "The Yellow Door House"
        cell.eventStatus.text = "You need to respond!"
        
        if(indexPath.section == 0){
            cell.backgroundColor = UIColor.lightTeal()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 129.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("eventHeaderCell") as! EventHeaderCell
        
        header.contentView.backgroundColor = UIColor.teal()
        
        var label = ""
        switch(section){
        case 0:
            label = "Upcoming"
            header.contentView.backgroundColor = UIColor.lightTeal()
        case 1:
            label = "Pending"
        case 2:
            label = "Past"
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}
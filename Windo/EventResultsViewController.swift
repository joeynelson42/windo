//
//  EventResultsViewController.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventResultsViewController: UIViewController {
    
    //MARK: Properties
    
    var resultsView = EventResultsView()
    var detailsTabBar: DetailsTabBarController!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = resultsView
        detailsTabBar = (tabBarController as! DetailsTabBarController)
        resultsView.members = detailsTabBar.members
        
        resultsView.resultsTableView.delegate = self
        resultsView.resultsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultsView.resultsTableView.setContentOffset(CGPoint(x: 0, y: -100), animated: false)
    }
}

extension EventResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsView.resultsTableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath) as! EventResultsCell
        cell.members = detailsTabBar.members
        cell.date = Date()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -45 {
            let filterY = 100 + scrollView.contentOffset.y
            
            resultsView.helpLabel.alpha = 1 - 2.5 * (filterY / 55)
            
            resultsView.filter.addConstraints(
                Constraint.tt.of(resultsView, offset: 55 - filterY),
                Constraint.cxcx.of(resultsView),
                Constraint.w.of(screenWidth),
                Constraint.h.of(55)
            )
            
            resultsView.helpLabel.addConstraints(
                Constraint.tt.of(resultsView, offset: 15 - filterY),
                Constraint.cxcx.of(resultsView)
            )
        }
        else {
            resultsView.filter.addConstraints(
                Constraint.tt.of(resultsView),
                Constraint.cxcx.of(resultsView),
                Constraint.w.of(screenWidth),
                Constraint.h.of(55)
            )
            
            resultsView.helpLabel.addConstraints(
                Constraint.tt.of(resultsView, offset: 15),
                Constraint.cxcx.of(resultsView)
            )
            
            UIView.animate(withDuration: 0.1, animations: {
                self.resultsView.helpLabel.alpha = 0.0
            })
        }
    }
}

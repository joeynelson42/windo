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
    
    var detailsView = EventDetailsView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = detailsView
    }
}

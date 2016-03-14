//
//  EventHeatmapViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventHeatmapViewController: UIViewController {
    
    //MARK: Properties
    
    var heatmapView = EventHeatmapView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = heatmapView
    }
}
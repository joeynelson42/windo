//
//  WindoTimeViewController.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoTimeViewController: UIViewController {
    
    //MARK: Properties
    
    var windoTimeView = WindoTimeView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = windoTimeView
    }
}
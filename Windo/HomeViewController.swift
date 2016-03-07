//
//  HomeViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    //MARK: Properties
    
    var homeView = HomeView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        self.view = homeView
        
    }
}

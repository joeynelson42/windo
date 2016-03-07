//
//  ViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    var loginView = LoginView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = loginView
    }
}

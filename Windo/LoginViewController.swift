//
//  ViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    //MARK: Properties
    
    var loginView = LoginView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = loginView
        
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserver(self, selector: #selector(LoginViewController.loadHomeScreen), name: kUserLoggedIn, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        loadHomeScreen()
    }
    
    @objc private func loadHomeScreen(){
        if let user = FIRAuth.auth()?.currentUser {
            
            //fetch user's events and open home screen on completion
            let rootVC = ContainerViewController()
            
            print("load home screen hit")
            
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }
    }
}

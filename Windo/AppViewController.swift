//
//  AppViewController.swift
//  Windo
//
//  Created by Joey on 7/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class AppController {
    
    static let sharedController = AppController()
    internal let viewController = AppViewController()
    let splashScreen = SplashScreenView()
    
    init() {
        showSplashScreen()
        CloudManager.sharedManager.getUser { (success, user) in
            if success {
                let homeVC = HomeViewController()
                self.displayContentController(homeVC)
                self.hideSplashScreen()
            } else {
                let phoneInputVC = PhoneNumberInputViewController()
                self.displayContentController(phoneInputVC)
                self.hideSplashScreen()
            }
        }
    }
    
    func displayContentController(content: UIViewController) {
        viewController.addChildViewController(content)
        viewController.view.addSubview(content.view)
        
        content.view.addConstraints(
            Constraint.llrr.of(viewController.view),
            Constraint.ttbb.of(viewController.view)
        )
        
        content.didMoveToParentViewController(viewController)
    }
    
    func hideContentController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func showSplashScreen() {
        viewController.view.addSubview(splashScreen)
        splashScreen.addConstraints(
            Constraint.llrr.of(viewController.view),
            Constraint.ttbb.of(viewController.view)
        )
        viewController.view.bringSubviewToFront(splashScreen)
    }
    
    func hideSplashScreen() {
        splashScreen.removeFromSuperview()
    }
}

class AppViewController: UIViewController {
    
    //MARK: Properties
    
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        if let font = UIFont(name: "Graphik-Medium", size: 20) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName : UIColor.mikeBlue()]
        }
        
        
    }
}
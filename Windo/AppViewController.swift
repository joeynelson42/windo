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
    var splashScreen = SplashScreenView()
    
    init() {
        splashScreen.alpha = 0.0
        showSplashScreen(UIColor.lightTeal(), fadeIn: false)
        
        CloudManager.sharedManager.getUser { (success, user) in
            DispatchQueue.main.async {
                if success {
                    UserManager.sharedManager.user = user
                    let homeVC = HomeViewController()
                    let navVC = UINavigationController(rootViewController: homeVC)
                    self.displayContentController(navVC)
                    self.hideSplashScreen()
                } else {
                    let phoneInputVC = PhoneNumberInputViewController()
                    self.displayContentController(phoneInputVC)
                    self.hideSplashScreen()
                }
            }
        }
    }
    
    func displayContentController(_ content: UIViewController) {
        viewController.addChildViewController(content)
        viewController.view.addSubview(content.view)
        
        // if splash screen is up, add the new viewController behind it
        if viewController.view.subviews.contains(splashScreen) {
            viewController.view.bringSubview(toFront: splashScreen)
        }
        
        content.view.addConstraints(
            Constraint.llrr.of(viewController.view),
            Constraint.ttbb.of(viewController.view)
        )
        
        content.didMove(toParentViewController: viewController)
    }
    
    func hideContentController(_ content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func showSplashScreen(_ color: UIColor, fadeIn: Bool) {
        splashScreen = SplashScreenView(color: color)
        if fadeIn { splashScreen.alpha = 0.0 }
        viewController.view.addSubview(splashScreen)
        splashScreen.addConstraints(
            Constraint.llrr.of(viewController.view),
            Constraint.ttbb.of(viewController.view)
        )
        viewController.view.bringSubview(toFront: splashScreen)
        
        if fadeIn {
            UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveLinear, animations: {
                self.splashScreen.alpha = 1.0
                }, completion: nil)
        }
    }
    
    func hideSplashScreen() {
        UIView.animate(withDuration: 0.25, delay: 0.5, options: .curveLinear, animations: {
            self.splashScreen.alpha = 0.0
        }) { (finished) in
            if finished {
                self.splashScreen.removeFromSuperview()
            }
        }
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

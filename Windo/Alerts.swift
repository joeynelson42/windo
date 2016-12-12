//
//  Alerts.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

protocol Alerts {
    func showAlert(_ alertView: WindoAlertView)
    func hideAlert(_ alertView: WindoAlertView)
}

extension Alerts where Self: UIViewController {
    
    func showAlert(_ alertView: WindoAlertView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: { 
                alertView.center = self.view.center
            }, completion: nil)
    }
    
    func hideAlert(_ alertView: WindoAlertView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
            alertView.transform = CGAffineTransform.identity
            }, completion: { finished in
                alertView.removeFromSuperview()
        })
    }
}

//
//  SettingsViewController.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    var settingsView = SettingsView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        settingsView.colorTheme = ColorTheme(color: .teal)
        view = settingsView
        settingsView.scrollView.delegate = self
        addTargets()
    }
    
    func addTargets() {
        settingsView.inviteFriendsCell.gr.addTarget(self, action: #selector(SettingsViewController.inviteFriendsTapped))
        settingsView.inviteFriendsCell.titleButton.addTarget(.TouchUpInside) { 
            self.inviteFriendsTapped()
        }
        
        settingsView.notificationsCell.gr.addTarget(self, action: #selector(SettingsViewController.notificationsTapped))
        settingsView.notificationsCell.titleButton.addTarget(.TouchUpInside) {
            self.notificationsTapped()
        }
        
        settingsView.accountCell.gr.addTarget(self, action: #selector(SettingsViewController.accountTapped))
        settingsView.accountCell.titleButton.addTarget(.TouchUpInside) {
            self.accountTapped()
        }
        
        settingsView.privacyCell.gr.addTarget(self, action: #selector(SettingsViewController.privacyTapped))
        settingsView.privacyCell.titleButton.addTarget(.TouchUpInside) {
            self.privacyTapped()
        }
        
        settingsView.supportCell.gr.addTarget(self, action: #selector(SettingsViewController.supportTapped))
        settingsView.supportCell.titleButton.addTarget(.TouchUpInside) {
            self.supportTapped()
        }
        
        settingsView.signOutCell.gr.addTarget(self, action: #selector(SettingsViewController.signOutTapped))
        settingsView.signOutCell.titleButton.addTarget(.TouchUpInside) {
            self.signOutTapped()
        }
    }
    
    func inviteFriendsTapped() {
        
    }
    
    func notificationsTapped() {
        
    }
    
    func accountTapped() {
        
    }
    
    func privacyTapped() {
        
    }
    
    func supportTapped() {
        
    }
    
    func signOutTapped() {
        
    }
}

extension SettingsViewController: UIScrollViewDelegate {
    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offset = scrollView.contentOffset.y
//        let navBarMaxOffset: CGFloat = screenHeight/3 - 60
//        let percent = offset/navBarMaxOffset
//        
//        if percent > 0 && percent < 0.25 {
//            UIView.animateWithDuration(0.25, animations: { 
//                scrollView.contentOffset.y = 0
//            })
//        } else if percent > 0 && percent < 1.0 {
//            UIView.animateWithDuration(0.25, animations: {
//                scrollView.contentOffset.y = 70
//            })
//        }
//    }
//    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        let navBarMaxOffset: CGFloat = screenHeight/3 - 60
//        let percent = offset/navBarMaxOffset
//        
//        if percent > 0 && percent < 0.5 {
//            UIView.animateWithDuration(0.25, animations: {
//                scrollView.contentOffset.y = 0
//            })
//        } else if percent > 0 && percent < 1.0 {
//            UIView.animateWithDuration(0.25, animations: {
//                scrollView.contentOffset.y = 70
//            })
//        }
//    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var navBarTransform = CGAffineTransformIdentity
        var initialsTranslate = CGAffineTransformIdentity
        var initialsScale = CGAffineTransformIdentity
        
        let navBarMaxOffset: CGFloat = screenHeight/3 - 60
        let navBarMaxScale: CGFloat = 0.25
        
        let initalsMaxScale: CGFloat = 0.4
        var initalsMaxOffset: CGFloat = screenHeight/7.5
        
        switch UIDevice().type {
        case .iPhone4:
            initalsMaxOffset = screenHeight/7.6
        case .iPhone5:
            initalsMaxOffset = screenHeight/7.7
        case .iPhone5S:
            initalsMaxOffset = screenHeight/7.7
        case .iPhone6:
            initalsMaxOffset = screenHeight/7.5
        case .iPhone6plus:
            initalsMaxOffset = screenHeight/7.4
        case .iPhone6S:
            initalsMaxOffset = screenHeight/7.5
        case .iPhone6Splus:
            initalsMaxOffset = screenHeight/7.4
        default:
            print("I am not equipped to handle this device")
        }
        
        let percent = offset/navBarMaxOffset
        
        print(offset)
        
        if offset < 0 {
            navBarTransform = CGAffineTransformMakeScale(-percent * navBarMaxScale + 1, -percent * navBarMaxScale + 1)
        } else {
            navBarTransform = CGAffineTransformMakeTranslation(0, max(-percent * navBarMaxOffset, -navBarMaxOffset))
            
            initialsTranslate = CGAffineTransformMakeTranslation(0, min(percent * initalsMaxOffset, initalsMaxOffset))
            
            initialsScale = CGAffineTransformMakeScale(max(1 - (percent * 1), initalsMaxScale), max(1 - (percent * 1), initalsMaxScale))
            
            settingsView.nameLabel.alpha = 1.0 - 2.0 * percent
        }
        
        settingsView.navBar.transform = navBarTransform
        settingsView.initials.transform = CGAffineTransformConcat(initialsScale, initialsTranslate)
    }
}
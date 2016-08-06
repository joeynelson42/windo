//
//  SettingsViewController.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    var settingsView = SettingsView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        settingsView.colorTheme = ColorTheme(color: .teal)
        view = settingsView
        settingsView.scrollView.delegate = self
        addTargets()
        addObservers()
    }
    
    func addTargets() {
        settingsView.inviteFriendsCell.gr.addTarget(self, action: #selector(SettingsViewController.inviteFriendsTapped))

        settingsView.notificationsCell.gr.addTarget(self, action: #selector(SettingsViewController.notificationsTapped))
        
        settingsView.accountCell.gr.addTarget(self, action: #selector(SettingsViewController.accountTapped))
        
        settingsView.privacyCell.gr.addTarget(self, action: #selector(SettingsViewController.privacyTapped))
        
        settingsView.supportCell.gr.addTarget(self, action: #selector(SettingsViewController.supportTapped))
        
        settingsView.signOutCell.gr.addTarget(self, action: #selector(SettingsViewController.signOutTapped))
        
        settingsView.backButton.addTarget(.TouchUpInside) {
            self.dismissAnimated()
        }
    }
    
    func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.saveFirstName), name: Constants.notifications.firstNameWasChanged, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.saveLastName), name: Constants.notifications.lastNameWasChanged, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.savePhone), name: Constants.notifications.phoneNumberWasChanged, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.saveEmail), name: Constants.notifications.emailWasChanged, object: nil)
    }
    
    func dismissAnimated() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction  = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        settingsView.window?.layer.addAnimation(transition, forKey: nil)
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    // MARK: Cell Tap Handling
    
    func inviteFriendsTapped() {
        //TODO: Show list similar to invitees in CreateEvent
    }
    
    func notificationsTapped() {
        settingsView.toggleNotifications()
    }
    
    func accountTapped() {
        settingsView.toggleAccount()
    }
    
    func privacyTapped() {
        // TODO: What do we show here?
    }
    
    func supportTapped() {
        if !MFMailComposeViewController.canSendMail() {
            // TODO: Alert mail not available
            return
        }
        
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        
        mailVC.setToRecipients(["joeyedmondnelson@gmail.com"])
        mailVC.setSubject("Windo Support Ticket #\(String.randomNumericString(4))")
        mailVC.setMessageBody("", isHTML: false)
        
        presentViewController(mailVC, animated: true, completion: nil)
    }
    
    func signOutTapped() {
        //TODO: Sign out functionality
    }
    
    // MARK: Notification Handling
    // TODO: This needs to be tested
    
    func saveFirstName() {
        guard let firstName = settingsView.accountSettingsView.firstNameTextField.text else { return }
        settingsView.accountSettingsView.firstNameSaveLabel.start()
        CloudManager.sharedManager.editUserInfo(["firstName":firstName], completion: { finished in
            self.settingsView.accountSettingsView.firstNameSaveLabel.finish()
        })
    }
    
    func saveLastName() {
        guard let lastName = settingsView.accountSettingsView.lastNameTextField.text else { return }
        settingsView.accountSettingsView.lastNameSaveLabel.start()
        CloudManager.sharedManager.editUserInfo(["lastName":lastName], completion: { finished in
            self.settingsView.accountSettingsView.lastNameSaveLabel.finish()
        })
    }
    
    func savePhone() {
        guard let phone = settingsView.accountSettingsView.phoneTextField.text else { return }
        settingsView.accountSettingsView.phoneSaveLabel.start()
        CloudManager.sharedManager.editUserInfo(["phoneNumber":phone], completion: { finished in
            self.settingsView.accountSettingsView.phoneSaveLabel.finish()
        })
    }
    
    func saveEmail() {
        guard let email = settingsView.accountSettingsView.emailTextField.text else { return }
        settingsView.accountSettingsView.emailSaveLabel.start()
        CloudManager.sharedManager.editUserInfo(["email":email], completion: { finished in
            self.settingsView.accountSettingsView.emailSaveLabel.finish()
        })
    }
    
}

extension SettingsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let navBarMaxOffset: CGFloat = screenHeight/3 - 60
        let percent = offset/navBarMaxOffset
        
        if percent > 0 && percent < 0.25 {
            UIView.animateWithDuration(0.25, animations: { 
                scrollView.contentOffset.y = 0
            })
        } else if percent > 0 && percent < 1.0 {
            UIView.animateWithDuration(0.25, animations: {
                scrollView.contentOffset.y = 160
            })
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let navBarMaxOffset: CGFloat = screenHeight/3 - 60
        let percent = offset/navBarMaxOffset
        
        if percent > 0 && percent < 0.5 {
            UIView.animateWithDuration(0.25, animations: {
                scrollView.contentOffset.y = 0
            })
        } else if percent > 0 && percent < 1.0 {
            UIView.animateWithDuration(0.25, animations: {
                scrollView.contentOffset.y = 70
            })
        }
    }
    
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
        
        print(offset/screenHeight)
        
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

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        if error != nil {
            return
        }
        
        if result == MFMailComposeResultSent {
            //TODO: Notify successful message sending
            print("sent!")
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
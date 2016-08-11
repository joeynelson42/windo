//
//  SettingsView.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//


import UIKit

enum SettingsViewState {
    case closed
    case notificationsExpanded
    case accountExpanded
}

class SettingsView: UIView {
    
    //MARK: Properties
    
    let navBar = UIView()
    let scrollView = UIScrollView()
    let containerView = UIView()
    let backButton = UIButton()
    
    let inviteFriendsCell = SettingsCell()
    let notificationsCell = SettingsCell()
    let accountCell = SettingsCell()
    let privacyCell = SettingsCell()
    let supportCell = SettingsCell()
    let signOutCell = SettingsCell()
    
    let accountSettingsView = AccountSettingsView()
    let notificationsView = NotificationSettingsView()
    
    var nameLabel = UILabel()
    var initials = UserInitialsView()
    var colorTheme: ColorTheme!
    
    var scrollViewHeight: CGFloat!
    var state = SettingsViewState.closed
    
    // View Constants
    let toggleOpenSpeed:Double = 0.35
    let toggleCloseSpeed:Double = 0.25
    
    let notificationsExpandedHeight:CGFloat = 311
    let notificationScrollToPercent: CGFloat = 0.334
    
    let accountExpandedHeight:CGFloat = 181
    let accountScrollToPercent: CGFloat = 0.29
    
    
    //MARK: Inits
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        scrollViewHeight = screenHeight/3 + (7 * 60)
        if scrollViewHeight < screenHeight {
            scrollViewHeight = screenHeight
        }
        
        backgroundColor = colorTheme.baseColor
        scrollView.contentSize = CGSizeMake(screenWidth, scrollViewHeight)
        scrollView.showsVerticalScrollIndicator = false
        
        containerView.backgroundColor = colorTheme.baseColor
        
        navBar.backgroundColor = colorTheme.lightColor
        
        backButton.setImage(UIImage(named: "whiteBackArrow"), forState: .Normal)
        
        initials.cornerRadius = 40
        initials.fontSize = 45
        
        nameLabel.text = "Yuki Dorff"
        nameLabel.font = UIFont.graphikMedium(22)
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.whiteColor()
        
        if let user = UserManager.sharedManager.user {
            nameLabel.text = user.fullName()
            initials.name = user.fullName()
        }
        
        inviteFriendsCell.titleLabel.text = "Invite Friends"
        inviteFriendsCell.colorTheme = colorTheme
        
        notificationsCell.titleLabel.text = "Notifications"
        notificationsCell.colorTheme = colorTheme
        
        accountCell.titleLabel.text = "Account"
        accountCell.colorTheme = colorTheme
        
        privacyCell.titleLabel.text = "Privacy"
        privacyCell.colorTheme = colorTheme
        
        supportCell.titleLabel.text = "Support"
        supportCell.colorTheme = colorTheme
        
        signOutCell.titleLabel.text = "Sign Out"
        signOutCell.colorTheme = colorTheme
        signOutCell.expandingSeparator.alpha = 0.0
        
        notificationsView.colorTheme = colorTheme
        accountSettingsView.colorTheme = colorTheme
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        navBar.addSubview(initials)
        navBar.addSubview(nameLabel)
        addSubview(navBar)
        addSubview(backButton)
        
        containerView.addSubview(inviteFriendsCell)
        containerView.addSubview(notificationsCell)
        containerView.addSubview(accountCell)
        containerView.addSubview(privacyCell)
        containerView.addSubview(supportCell)
        containerView.addSubview(signOutCell)
        
        accountCell.expandingSeparator.addSubview(accountSettingsView)
        notificationsCell.expandingSeparator.addSubview(notificationsView)
    }
    
    func applyConstraints(){
        scrollView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
        
        containerView.addConstraints(
            Constraint.tt.of(scrollView),
            Constraint.ll.of(scrollView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(scrollViewHeight)
        )
        
        navBar.addConstraints(
            Constraint.tt.of(self),
            Constraint.llrr.of(self),
            Constraint.h.of(screenHeight / 3)
        )
        
        initials.addConstraints(
            Constraint.cxcx.of(navBar),
            Constraint.cycy.of(navBar),
            Constraint.wh.of(80)
        )
        
        nameLabel.addConstraints(
            Constraint.tb.of(initials, offset: 20),
            Constraint.cxcx.of(navBar)
        )
        
        backButton.addConstraints(
            Constraint.tt.of(self, offset: 30),
            Constraint.rr.of(self, offset: -30),
            Constraint.wh.of(20)
        )
        
        inviteFriendsCell.addConstraints(
            Constraint.tt.of(containerView, offset: screenHeight/3),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        notificationsCell.addConstraints(
            Constraint.tb.of(inviteFriendsCell),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        accountCell.addConstraints(
            Constraint.tb.of(notificationsCell),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        privacyCell.addConstraints(
            Constraint.tb.of(accountCell),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        supportCell.addConstraints(
            Constraint.tb.of(privacyCell),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        signOutCell.addConstraints(
            Constraint.tb.of(supportCell),
            Constraint.llrr.of(containerView),
            Constraint.h.of(60)
        )
        
        accountSettingsView.fillSuperview()
        notificationsView.fillSuperview()
    }
    
    // MARK: Methods
    
    func expandScrollViewWithHeight(height: CGFloat) {
        scrollView.contentSize = CGSizeMake(screenWidth, scrollViewHeight + height)
        containerView.addConstraints(
            Constraint.tt.of(scrollView),
            Constraint.ll.of(scrollView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(scrollViewHeight + height)
        )
        
        UIView.animateWithDuration(toggleOpenSpeed) {
            self.layoutIfNeeded()
        }
    }
    
    func close() {
        state = .closed
        endEditing(true)
        applyConstraints()
        UIView.animateWithDuration(toggleCloseSpeed, animations: {
            self.scrollView.contentOffset.y = 0
            self.layoutIfNeeded()
            }, completion: { (finished) in
                self.scrollView.contentSize = CGSizeMake(screenWidth, self.scrollViewHeight)
        })
    }
    
    func toggleNotifications() {
        if state == .notificationsExpanded {
            notificationsCell.toggleSeparatorWithHeight(0)
            close()
        } else {
            closeExpandedCell()
            state = .notificationsExpanded
            expandScrollViewWithHeight(notificationsExpandedHeight)
            notificationsCell.addConstraints(
                Constraint.tb.of(inviteFriendsCell),
                Constraint.llrr.of(containerView),
                Constraint.h.of(notificationsExpandedHeight + 60)
            )
            notificationsCell.toggleSeparatorWithHeight(notificationsExpandedHeight)
            UIView.animateWithDuration(toggleOpenSpeed) {
                self.scrollView.contentOffset.y = screenHeight * self.notificationScrollToPercent
                self.layoutIfNeeded()
            }
        }
    }
    
    func toggleAccount() {
        if state == .accountExpanded {
            accountCell.toggleSeparatorWithHeight(0)
            close()
        } else {
            closeExpandedCell()
            state = .accountExpanded
            expandScrollViewWithHeight(accountExpandedHeight)
            accountCell.addConstraints(
                Constraint.tb.of(notificationsCell),
                Constraint.llrr.of(containerView),
                Constraint.h.of(accountExpandedHeight + 60)
            )
            accountCell.toggleSeparatorWithHeight(accountExpandedHeight)
            
            UIView.animateWithDuration(toggleOpenSpeed) {
                self.scrollView.contentOffset.y = screenHeight * self.accountScrollToPercent
                self.layoutIfNeeded()
            }
        }
    }
    
    func closeExpandedCell() {
        applyConstraints()
        switch state {
        case .notificationsExpanded:
            notificationsCell.toggleSeparatorWithHeight(0)
        case .accountExpanded:
            accountCell.toggleSeparatorWithHeight(0)
        default:
            return
        }
    }
}
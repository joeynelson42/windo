//
//  SettingsView.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//


import UIKit

class SettingsView: UIView {
    
    //MARK: Properties
    
    let navBar = UIView()
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    var nameLabel = UILabel()
    var initials = UserInitialsView()
    var colorTheme: ColorTheme!
    
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
        backgroundColor = colorTheme.lightColor
        scrollView.contentSize = CGSizeMake(screenWidth, screenHeight * 2)
//        scrollView.showsVerticalScrollIndicator = false
        
        containerView.backgroundColor = colorTheme.baseColor
        
        navBar.backgroundColor = colorTheme.lightColor
        
        initials.cornerRadius = 40
        initials.fontSize = 50
        
        nameLabel.text = "Yuki Dorff"
        nameLabel.font = UIFont.graphikMedium(22)
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.whiteColor()
        
        if let user = UserManager.sharedManager.user {
            nameLabel.text = user.fullName()
            initials.name = user.fullName()
        }
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        navBar.addSubview(initials)
        navBar.addSubview(nameLabel)
        addSubview(navBar)
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
            Constraint.h.of(screenHeight * 2)
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
    }
}
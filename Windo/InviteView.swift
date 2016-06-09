//
//  InviteView.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteView: UIView {
    
    //MARK: Properties
    var inviteeTableView = UITableView()
    var stackViewContainer = UIView()
    var inviteeLabel = UILabel()
    
    var inviteePlaceholderText = "Select people to invite!"
    
    //MARK: View Configuration
    
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        inviteeTableView.backgroundColor = UIColor.darkBlue()
        inviteeTableView.showsVerticalScrollIndicator = false
        inviteeTableView.separatorColor = UIColor.blue()
        inviteeTableView.registerClass(InviteeCell.self, forCellReuseIdentifier: "inviteeCell")
        inviteeTableView.registerClass(InviteeHeaderCell.self, forHeaderFooterViewReuseIdentifier: "inviteeHeaderCell")
        
        if inviteeLabel.text == "" {
            inviteeLabel.text = inviteePlaceholderText
        }
        inviteeLabel.textColor = UIColor.whiteColor()
        inviteeLabel.font = UIFont.graphikRegular(18)
        inviteeLabel.tintColor = UIColor.whiteColor()
        
        stackViewContainer.backgroundColor = UIColor.blue()
        
        addSubview(stackViewContainer)
        addSubview(inviteeTableView)
        addSubview(inviteeLabel)
    }
    
    func applyConstraints(){
        stackViewContainer.addConstraints(
            Constraint.bb.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(45)
        )
        
        inviteeLabel.addConstraints(
            Constraint.cycy.of(stackViewContainer),
            Constraint.ll.of(stackViewContainer, offset: 16),
            Constraint.w.of(screenWidth),
            Constraint.h.of(18)
        )
        
        inviteeTableView.addConstraints(
            Constraint.tt.of(self),
            Constraint.bt.of(stackViewContainer),
            Constraint.llrr.of(self),
            Constraint.w.of(screenWidth)
        )
    }
}
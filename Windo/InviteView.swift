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
    
    //MARK: View Configuration
    
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        inviteeTableView.backgroundColor = UIColor.whiteColor()
        inviteeTableView.showsVerticalScrollIndicator = false
        inviteeTableView.separatorColor = UIColor.blue()
        inviteeTableView.registerClass(InviteeCell.self, forCellReuseIdentifier: "inviteeCell")
        inviteeTableView.registerClass(InviteeHeaderCell.self, forHeaderFooterViewReuseIdentifier: "inviteeHeaderCell")
        
        stackViewContainer.backgroundColor = UIColor.blue()
        
        addSubview(stackViewContainer)
        addSubview(inviteeTableView)
    }
    
    func applyConstraints(){
        stackViewContainer.addConstraints(
            Constraint.tt.of(self, offset: 64),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60))
        
        inviteeTableView.addConstraints(
            Constraint.tb.of(stackViewContainer, offset: 0),
            Constraint.llrr.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 124))
        
    }
}
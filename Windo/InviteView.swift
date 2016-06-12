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
    var searchBar = UISearchBar()
    
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
        
        searchBar.barTintColor = UIColor.lightBlue()
        searchBar.tintColor = UIColor.whiteColor()
        
        
        searchBar.setImage(UIImage(named:"whiteSearchIcon"), forSearchBarIcon: UISearchBarIcon.Search, state: .Normal)
        searchBar.setImage(UIImage(named:"whiteClearButton"), forSearchBarIcon: UISearchBarIcon.Clear, state: .Normal)
        searchBar.setImage(UIImage(named:"whiteClearButton"), forSearchBarIcon: UISearchBarIcon.Clear, state: .Highlighted)
                
        if let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.clearColor()
            textFieldInsideSearchBar.textColor = UIColor.whiteColor()
        }
        
        addSubview(stackViewContainer)
        addSubview(inviteeTableView)
        addSubview(inviteeLabel)
        addSubview(searchBar)
    }
    
    func applyConstraints(){
        stackViewContainer.addConstraints(
            Constraint.bb.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(45)
        )
        
        searchBar.addConstraints(
            Constraint.tt.of(self),
            Constraint.llrr.of(self)
        )
        
        inviteeLabel.addConstraints(
            Constraint.cycy.of(stackViewContainer),
            Constraint.ll.of(stackViewContainer, offset: 16),
            Constraint.w.of(screenWidth),
            Constraint.h.of(18)
        )
        
        inviteeTableView.addConstraints(
            Constraint.tb.of(searchBar),
            Constraint.bt.of(stackViewContainer),
            Constraint.llrr.of(self),
            Constraint.w.of(screenWidth)
        )
    }
}
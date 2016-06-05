//
//  EventMessagesView.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventMessagesView: UIView {
    
    //MARK: Properties
    let newMessageContainer = UIView()
    
    let recipientsContainer = UIView()
    
    let messagesTableView = UITableView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightPurple()
        
        recipientsContainer.backgroundColor = UIColor.lightPurple()
        
        newMessageContainer.backgroundColor = UIColor.purple()
        
        messagesTableView.backgroundColor = UIColor.purple()
        messagesTableView.registerClass(ChatCell.self, forCellReuseIdentifier: "chatCell")
        
        addSubviews(recipientsContainer, newMessageContainer, messagesTableView)
    }
    
    func applyConstraints(){
        recipientsContainer.addConstraints(
            Constraint.tt.of(self),
            Constraint.llrr.of(self),
            Constraint.h.of(50)
        )
        
        newMessageContainer.addConstraints(
            Constraint.bb.of(self, offset: -50),
            Constraint.llrr.of(self),
            Constraint.h.of(40)
        )
        
        messagesTableView.addConstraints(
            Constraint.tb.of(recipientsContainer),
            Constraint.llrr.of(self),
            Constraint.bt.of(newMessageContainer)
        )
    }
}

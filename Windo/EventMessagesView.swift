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
    let messageTextField = UITextField()
    let sendButton = UIButton()
    
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
        
        newMessageContainer.backgroundColor = UIColor.darkPurple()
        
        messageTextField.backgroundColor = UIColor.white
        
        sendButton.backgroundColor = newMessageContainer.backgroundColor
        sendButton.setTitle("SEND", for: UIControlState())
        sendButton.setTitleColor(UIColor.white, for: UIControlState())
        sendButton.setTitleColor(UIColor.darkPurple(), for: .highlighted)
        sendButton.titleLabel?.font = UIFont.graphikMedium(13)
        
        messagesTableView.backgroundColor = UIColor.purple()
        messagesTableView.separatorStyle = .none
        messagesTableView.allowsSelection = false
        messagesTableView.register(IncomingChatCell.self, forCellReuseIdentifier: "incomingChatCell")
        messagesTableView.register(OutgoingChatCell.self, forCellReuseIdentifier: "outgoingChatCell")
        
        addSubviews(recipientsContainer, messagesTableView)
        addSubview(newMessageContainer)
        newMessageContainer.addSubview(messageTextField)
        newMessageContainer.addSubview(sendButton)
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
        
        messageTextField.addConstraints(
            Constraint.ll.of(newMessageContainer, offset: 5),
            Constraint.ttbb.of(newMessageContainer, offset: 5),
            Constraint.rr.of(newMessageContainer, offset: -60)
        )
        
        sendButton.addConstraints(
            Constraint.ttbb.of(newMessageContainer),
            Constraint.lr.of(messageTextField, offset: 5),
            Constraint.rr.of(newMessageContainer, offset: -5)
        )
        
        messagesTableView.addConstraints(
            Constraint.tb.of(recipientsContainer),
            Constraint.llrr.of(self),
            Constraint.bt.of(newMessageContainer)
        )
    }
}

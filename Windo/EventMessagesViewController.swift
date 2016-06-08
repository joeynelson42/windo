//
//  EventMessagesViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventMessagesViewController: UIViewController {
    
    //MARK: Properties
    
    var messagesView = EventMessagesView()
    var cells = [String]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = messagesView
        messagesView.messagesTableView.delegate = self
        messagesView.messagesTableView.dataSource = self
        
        cells = ["1", "2", "3"]
        
        messagesView.sendButton.addTarget(self, action: #selector(EventMessagesViewController.sendMessage), forControlEvents: .TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EventMessagesViewController.keyboardDidShow(_:)), name:UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EventMessagesViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EventMessagesViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func sendMessage() {
        cells.append("\(messagesView.messageTextField.text!)")
        let indexP = NSIndexPath(forRow: cells.count - 1, inSection: 0)
        messagesView.messagesTableView.insertRowsAtIndexPaths([indexP], withRowAnimation: UITableViewRowAnimation.Bottom)
        messagesView.messagesTableView.scrollToRowAtIndexPath(indexP, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    func keyboardDidShow(sender: NSNotification) {
        let info  = sender.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = messagesView.convertRect(rawFrame, fromView: nil)
        keyboardHeight = keyboardFrame.height
        
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -keyboardHeight),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animateWithDuration(0.15) {
            self.messagesView.layoutIfNeeded()
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {        
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -keyboardHeight),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animateWithDuration(0.15) {
            self.messagesView.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -50),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animateWithDuration(0.15) {
            self.messagesView.layoutIfNeeded()
        }
    }
}

extension EventMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("incomingChatCell") as! IncomingChatCell
            cell.message.text = cells[indexPath.row]
            cell.backgroundColor = UIColor.purple()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("outgoingChatCell") as! OutgoingChatCell
            cell.message.text = cells[indexPath.row]
            cell.backgroundColor = UIColor.purple()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
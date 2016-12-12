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
        
        cells = ["1", "2", "hey this is a bunch of text hey this is a bunch of text hey this is a bunch of text"]
        
        messagesView.sendButton.addTarget(self, action: #selector(EventMessagesViewController.sendMessage), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EventMessagesViewController.keyboardDidShow(_:)), name:NSNotification.Name.UIKeyboardDidShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(EventMessagesViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(EventMessagesViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func sendMessage() {
        cells.append("\(messagesView.messageTextField.text!)")
        let indexP = IndexPath(row: cells.count - 1, section: 0)
        messagesView.messagesTableView.insertRows(at: [indexP], with: UITableViewRowAnimation.bottom)
        messagesView.messagesTableView.scrollToRow(at: indexP, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    
    func keyboardDidShow(_ sender: Notification) {
        let info  = (sender as NSNotification).userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        
        let rawFrame = value.cgRectValue
        let keyboardFrame = messagesView.convert(rawFrame!, from: nil)
        keyboardHeight = keyboardFrame.height
        
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -keyboardHeight),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animate(withDuration: 0.15, animations: {
            self.messagesView.layoutIfNeeded()
        }) 
    }
    
    func keyboardWillShow(_ sender: Notification) {
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -keyboardHeight),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animate(withDuration: 0.15, animations: {
            self.messagesView.layoutIfNeeded()
        }) 
    }
    
    func keyboardWillHide(_ sender: Notification) {
        messagesView.newMessageContainer.addConstraints(
            Constraint.bb.of(messagesView, offset: -50),
            Constraint.llrr.of(messagesView),
            Constraint.h.of(40)
        )
        
        UIView.animate(withDuration: 0.15, animations: {
            self.messagesView.layoutIfNeeded()
        }) 
    }
}

extension EventMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomingChatCell") as! IncomingChatCell
            cell.message.text = cells[(indexPath as NSIndexPath).row]
            cell.backgroundColor = UIColor.purple()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "outgoingChatCell") as! OutgoingChatCell
            cell.message.text = cells[(indexPath as NSIndexPath).row]
            cell.backgroundColor = UIColor.purple()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = heightForView(cells[(indexPath as NSIndexPath).row], font: UIFont.graphikMedium(16), width: screenWidth - 40)
        
        return height + 42
    }
    
    func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

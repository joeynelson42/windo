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
    }
    
    func sendMessage() {
        cells.append("\(messagesView.messageTextField.text!)")
        let indexP = NSIndexPath(forRow: cells.count - 1, inSection: 0)
        messagesView.messagesTableView.insertRowsAtIndexPaths([indexP], withRowAnimation: UITableViewRowAnimation.Bottom)
        messagesView.messagesTableView.scrollToRowAtIndexPath(indexP, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
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
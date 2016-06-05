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
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = messagesView
        messagesView.messagesTableView.delegate = self
        messagesView.messagesTableView.dataSource = self
    }
}

extension EventMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell") as! ChatCell
        
        cell.backgroundColor = UIColor.purple()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
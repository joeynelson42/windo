//
//  DataProvider.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataProvider {
    
    static let sharedProvider = DataProvider()
    let dbRef = FIRDatabase.database().reference()

    // PATHS
    let userPath = "users"
    let eventPath = "events"
    let windoPath = "windos"
    
    // MARK: User
    // TODO: Google and Facebook login
    
    // MARK: Events
    func createEvent(newEvent: Event) {
        // TODO: for each member of event, add the event's ID to their list of events
        // TODO: create enum structure for user's status within event: e.g. needs to respond, has responded, etc.
        
        for member in newEvent.members {
            let userID = member.ID
            dbRef.child(userPath).child(userID).child("eventIDs").child(newEvent.ID).child("upcoming").setValue("user status")
        }
        
        self.dbRef.child(eventPath).child(newEvent.ID).setValue(newEvent)
        
    }
    
    func getEventByID(ID: String) -> Event {
        let event = Event()
        
        
//        let recentPostsQuery = (dbRef.child(eventPath).queryEqualToValue(AnyObject?))
        
        return event
    }
    
    
    
    
}
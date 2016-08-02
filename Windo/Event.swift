//
//  Event.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CoreLocation

struct Event {
    var ID: String!
    var name: String!
    var location: CLLocation!
    var members: [String]!
    var eventCreator: String!
    var dateCreated: NSDate!
    var eventWindoID: String!
    var memberWindoIDs: [String]!
    var possibleTimes: [NSDate]!
    var originTimeZone: String!
        
    init(id: String, name: String, location: CLLocation, members: [String], eventCreator: String, dateCreated: NSDate, eventWindo: String, memberSubmissions: [String], possibleTimes: [NSDate], timeZone: String) {
        self.ID = id
        self.name = name
        self.location = location
        self.members = members
        self.eventCreator = eventCreator
        self.dateCreated = dateCreated
        self.eventWindoID = eventWindo
        self.memberWindoIDs = memberSubmissions
        self.possibleTimes = possibleTimes
        self.originTimeZone = timeZone
    }
}
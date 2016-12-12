//
//  Windo.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

struct Windo {
    
    var ID: String!
    var ownerID: String!
    var eventID: String!
    var times: [Date]!
    var dateCreated: Date!
    
    init(id: String, ownerID: String, eventID: String, times: [Date], dateCreated: Date) {
        self.ID = id
        self.ownerID = ownerID
        self.eventID = eventID
        self.times = times
        self.dateCreated = dateCreated
    }
}

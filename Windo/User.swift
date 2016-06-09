//
//  User.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class User {

    var ID: String!
    var email: String!
    var facebookID: String!
    var name: String!
    var friendIDs: [String]!
    var eventIDs: [String]!
    
    // MARK: Public
    
    // MARK: Private
    
    
}

enum ResponseStatus : String {
    case NeedsResponse = "needsResponse", HasResponded = "hasResponded"
    static let allValues = [NeedsResponse, HasResponded]
}

/*
 "eventIDs": {
    "upcoming": {
        "eventID": { ResponseStatus }
        "eventID1": { "hasResponded" },
        "eventID2": { "responseNeeded" },
    "past": {
 
 */
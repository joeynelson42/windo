//
//  User.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

struct User {
    var phoneNumber: String!
    var email: String!
    var facebookID: String!
    var googleID: String!
    var name: String!
    var eventIDs: [String]!
    var imageRecordName: String!
}



//class User {
//
//    var ID: String!
//    var email: String!
//    var facebookID: String!
//    var firstName: String!
//    var lastName: String!
//    var friendIDs: [String]!
//    var eventIDs: [String]!
//    
//    // MARK: Public
//    init() {
//        
//    }
//    
//    init(id: String, email: String, facebookID: String, name: String, friendIDs: [String], eventIDs: [String]) {
//        self.ID = id
//        self.email = email
//        self.facebookID = facebookID
////        self.name = name
//        self.friendIDs = friendIDs
//        self.eventIDs = eventIDs
//    }
//    
//    
//    // MARK: Private
//    
//    
//}
//
//enum ResponseStatus : String {
//    case NeedsResponse = "needsResponse", HasResponded = "hasResponded"
//    static let allValues = [NeedsResponse, HasResponded]
//}
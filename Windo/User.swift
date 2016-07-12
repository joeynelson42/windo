//
//  User.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CloudKit

struct User {
    var recordID: CKRecordID!
    var phoneNumber: String!
    var email: String!
    var facebookID: String!
    var googleID: String!
    var firstName: String!
    var lastName: String!
    var imageRecordID: CKRecordID!
    
    init(id: CKRecordID, number: String!, firstName: String, lastName: String) {
        self.recordID = id
        self.phoneNumber = number
        self.email = ""
        self.facebookID = ""
        self.googleID = ""
        self.firstName = firstName
        self.lastName = lastName
        self.imageRecordID = nil
    }
    
    init(id: CKRecordID, number: String!, email: String, facebookID: String, googleID: String, firstName: String, lastName: String, imageRecordID: CKRecordID) {
                self.recordID = id
                self.phoneNumber = number
                self.email = email
                self.facebookID = facebookID
                self.googleID = googleID
                self.firstName = firstName
                self.lastName = lastName
                self.imageRecordID = imageRecordID
            }
    
    
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
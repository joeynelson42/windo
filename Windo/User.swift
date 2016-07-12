//
//  User.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CloudKit

class User: NSObject, NSCoding{
    var recordID: String!
    var phoneNumber: String!
    var email: String!
    var facebookID: String!
    var googleID: String!
    var firstName: String!
    var lastName: String!
    var imageRecordID: String!
    
    init(id: String, number: String!, firstName: String, lastName: String) {
        self.recordID = id
        self.phoneNumber = number
        self.email = ""
        self.facebookID = ""
        self.googleID = ""
        self.firstName = firstName
        self.lastName = lastName
        self.imageRecordID = nil
    }
    
    init(id: String, number: String!, email: String, facebookID: String, googleID: String, firstName: String, lastName: String, imageRecordID: String) {
        self.recordID = id
        self.phoneNumber = number
        self.email = email
        self.facebookID = facebookID
        self.googleID = googleID
        self.firstName = firstName
        self.lastName = lastName
        self.imageRecordID = imageRecordID
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.recordID = aDecoder.decodeObjectForKey("recordID") as! String
        self.phoneNumber = aDecoder.decodeObjectForKey("phoneNumber") as! String
        self.email = aDecoder.decodeObjectForKey("email") as! String
        self.facebookID = aDecoder.decodeObjectForKey("facebookID") as! String
        self.googleID = aDecoder.decodeObjectForKey("googleID") as! String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as! String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as! String
        self.imageRecordID = aDecoder.decodeObjectForKey("imageRecordID") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(recordID, forKey: "recordID")
        aCoder.encodeObject(phoneNumber, forKey: "phoneNumber")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(facebookID, forKey: "facebookID")
        aCoder.encodeObject(googleID, forKey: "googleID")
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeObject(imageRecordID, forKey: "imageRecordID")
    }
}
































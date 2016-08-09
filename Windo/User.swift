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

class Invitee: NSObject, NSCoding {
    var firstName: String!
    var lastName: String!
    var phoneNumber: String!
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    // TODO: Make this work
    var formattedPhoneNumber: String {
        get {
            var formatted = phoneNumber.stringByReplacingOccurrencesOfString("+", withString: "")
            
            if String(formatted.characters.first!) == "1" {
                formatted.removeAtIndex(formatted.startIndex.advancedBy(0))
            }
            
            var indicesToRemove = [Int]()
            for (index, char) in formatted.characters.enumerate() {
                let stringChar = String(char)
                if !stringChar.isDigit() {
                    indicesToRemove.append(index)
                }
            }
            
            for index in indicesToRemove.reverse() {
                formatted.removeAtIndex(formatted.startIndex.advancedBy(index))
            }
            
            formatted.insert("(", atIndex: formatted.startIndex.advancedBy(0))
            formatted.insert(")", atIndex: formatted.startIndex.advancedBy(4))
            formatted.insert("-", atIndex: formatted.startIndex.advancedBy(8))
            
            return formatted
        }
    }
    
    init(number: String!, firstName: String, lastName: String) {
        self.phoneNumber = number
        self.firstName = firstName
        self.lastName = lastName
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.phoneNumber = aDecoder.decodeObjectForKey("phoneNumber") as! String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as! String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(phoneNumber, forKey: "phoneNumber")
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
    }
}

struct EventList {
    var phoneNumber: String!
    var events: [String]!
    
    init(phoneNumber: String, events: [String]) {
        self.phoneNumber = phoneNumber
        self.events = events
    }
}





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
        self.recordID = aDecoder.decodeObject(forKey: "recordID") as! String
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.facebookID = aDecoder.decodeObject(forKey: "facebookID") as! String
        self.googleID = aDecoder.decodeObject(forKey: "googleID") as! String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        self.imageRecordID = aDecoder.decodeObject(forKey: "imageRecordID") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(recordID, forKey: "recordID")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(facebookID, forKey: "facebookID")
        aCoder.encode(googleID, forKey: "googleID")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(imageRecordID, forKey: "imageRecordID")
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
            var formatted = phoneNumber.replacingOccurrences(of: "+", with: "")
            
            if String(formatted.characters.first!) == "1" {
                formatted.remove(at: formatted.characters.index(formatted.startIndex, offsetBy: 0))
            }
            
            var indicesToRemove = [Int]()
            for (index, char) in formatted.characters.enumerated() {
                let stringChar = String(char)
                if !stringChar.isDigit() {
                    indicesToRemove.append(index)
                }
            }
            
            for index in indicesToRemove.reversed() {
                formatted.remove(at: formatted.characters.index(formatted.startIndex, offsetBy: index))
            }
            
            formatted.insert("(", at: formatted.characters.index(formatted.startIndex, offsetBy: 0))
            formatted.insert(")", at: formatted.characters.index(formatted.startIndex, offsetBy: 4))
            formatted.insert("-", at: formatted.characters.index(formatted.startIndex, offsetBy: 8))
            
            return formatted
        }
    }
    
    init(number: String!, firstName: String, lastName: String) {
        self.phoneNumber = number
        self.firstName = firstName
        self.lastName = lastName
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
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





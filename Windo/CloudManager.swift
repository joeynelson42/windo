//
//  CloudManager.swift
//  Windo
//
//  Created by Joey on 7/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CloudKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class CloudManager: NSObject {
    
    static let sharedManager = CloudManager()
    var defaultContainer = CKContainer.default()
    let publicDB = CKContainer.default().publicCloudDatabase
    let privateDB = CKContainer.default().privateCloudDatabase
    
    let userRecordType = "User"
    let userEventListRecordType = "UserEventList"
    let eventRecordType = "Event"
    let windoRecordType = "Windo"
    let messageRecordType = "Message"
    
    typealias PhoneNumber = String
    
    func requestPermission(_ completionHandler: @escaping (_ granted: Bool) -> ()) {
        defaultContainer.requestApplicationPermission(CKApplicationPermissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            if applicationPermissionStatus == CKApplicationPermissionStatus.granted {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    // MARK: User
    func getUser(_ completionHandler: (_ success: Bool, _ user: User?) -> ()) {
        getUserFromDefaults { (success, defaultsUser) in
            if success {
                completionHandler(true, defaultsUser)
            } else {
                // User is new/not logged in
                completionHandler(false, nil)
            }
        }
    }
    
    /// Will return user object if stored in NSUserDefaults
    func getUserFromDefaults(_ completionHandler: (_ success: Bool, _ user: User?) -> ()) {
        if let userData = UserDefaults.standard.object(forKey: Constants.userDefaultKeys.kUser) as? Data {
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
            completionHandler(true, user)
        } else {
            completionHandler(false, nil)
        }
    }
    
    /// Sends fetch request to iCloud using the phoneNumber as the predicate
    func getUserWithPhoneNumber(_ phoneNumber: String, completionHandler: @escaping (_ success: Bool, _ user: User?) -> ()) {
        let predicate = NSPredicate(format: "phoneNumber == '\(phoneNumber)'")
        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
        self.privateDB.perform(query, inZoneWith: nil) { user, error in
            if error != nil {
                print("failed to fetch user \n \(error)")
                completionHandler(false, nil)
            } else {
                // create User from CKRecord
                if let userRecord = user?.first {
                    let fetchedUser = self.parseUserRecord(userRecord)
                    self.storeUserInDefaults(fetchedUser)
                    completionHandler(true, fetchedUser)
                } else {
                    completionHandler(false, nil)
                }
            }
        }
    }
    
    /// Stores user object in iCloud and, if successful, saves it to UserDefaults
    func saveNewUser(_ user: User, completionHandler: @escaping (_ user: User?,_ success: Bool) -> ()) {
        defaultContainer.fetchUserRecordID { (appleUserRecordID, error) in
            if error != nil {
                // handle error
                completionHandler(nil, false)
            } else {
                let recordID = CKRecordID(recordName: user.phoneNumber)
                let userRecord = CKRecord(recordType: self.userRecordType, recordID: recordID)
                user.recordID = appleUserRecordID?.recordName
                
                userRecord.setObject(user.recordID as CKRecordValue?, forKey: "userID")
                userRecord.setObject(user.phoneNumber as CKRecordValue?, forKey: "phoneNumber")
                userRecord.setObject(user.firstName as CKRecordValue?, forKey: "firstName")
                userRecord.setObject(user.lastName as CKRecordValue?, forKey: "lastName")
                userRecord.setObject(user.email as CKRecordValue?, forKey: "email")
                userRecord.setObject(user.facebookID as CKRecordValue?, forKey: "facebookID")
                userRecord.setObject(user.googleID as CKRecordValue?, forKey: "googleID")
                userRecord.setObject(user.imageRecordID as CKRecordValue?, forKey: "imageRecordID")
                
                self.savePrivateRecord(userRecord, completionHandler: { (success) in
                    if success {
                        self.storeUserInDefaults(user)
                        completionHandler(user, true)
                    } else {
                        // handle failure
                        completionHandler(nil, false)
                    }
                })
            }
        }
    }
    
    func editUserInfo(_ userInfo: [String:String], completion: (Bool)->()) {
        // TODO: this
//        let phoneNumber = 
//        let predicate = NSPredicate(format: "phoneNumber == '\()'")
//        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
//        self.privateDB.performQuery(query, inZoneWithID: nil) { user, error in
//            if error != nil {
//                print("failed to fetch user \n \(error)")
//                completionHandler(success: false, user: nil)
//            } else {
//                // create User from CKRecord
//                if let userRecord = user?.first {
//                    let fetchedUser = self.parseUserRecord(userRecord)
//                    self.storeUserInDefaults(fetchedUser)
//                    completionHandler(success: true, user: fetchedUser)
//                }
//            }
//        }
//        
//        for (field, newInfo) in userInfo {
//            
//        }
//        
//        completion(true)
    }
    
    fileprivate func storeUserInDefaults(_ user: User) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: Constants.userDefaultKeys.kUser)
    }
    
    // MARK: EventList
    /// Fetches user event list with a completion handler that includes either the fetched event list or the one created in the case of it being a new user with no events
//    func fetchUserEventList(user: User, completionHandler: (eventList: EventList?, success: Bool) -> ()) {
//        let predicate = NSPredicate(format: "phoneNumber == \(user.phoneNumber)")
//        let query = CKQuery(recordType: userEventListRecordType, predicate: predicate)
//        
//        publicDB.performQuery(query, inZoneWithID: nil) { (results, error) in
//            if error != nil {
//                // handle error
//            } else if results?.count > 0 {
//                let record = results![0]
//                let eventList = self.parseEventListRecord(record)
//            } else if results?.count == 0 {
//                //create new EventList for user
//            }
//        }
//    }
    
    func updateEventMembersEventListsWithEventID(_ users: [PhoneNumber], eventID: String) {
        updateExistingEventListsWithEventID(users, eventID: eventID) { (success, eventListsToCreate, error) in
            if error != nil {
                //handle error
            } else if eventListsToCreate?.count > 0 {
                for phoneNumber in eventListsToCreate! {
                    let eventList = EventList(phoneNumber: phoneNumber, events: [eventID])
                    self.updateUserEventList(eventList)
                }
            }
        }
    }
    
    /// Updates the EventLists of each user with the new Event's ID
    func updateExistingEventListsWithEventID(_ users: [PhoneNumber], eventID: String, completionHandler: @escaping (_ success:Bool, _ eventListsToCreate: [PhoneNumber]?, _ error: NSError?)->()) {
        
        var usersWithoutEventLists = users
        getExistingEventListRecordsWithUserList(users) { (success, eventListRecords, error) in
            if error != nil {
                //handle error
            } else if eventListRecords?.count > 0 {
                for record in eventListRecords! {
                    let eventList = self.parseEventListRecord(record)
                    self.updateUserEventList(eventList)
                    usersWithoutEventLists.remove(at: usersWithoutEventLists.index(of: eventList.phoneNumber)!)
                }
                
                completionHandler(true, usersWithoutEventLists, error)
            }
        }
        
    }
    
    func getExistingEventListRecordsWithUserList(_ users: [PhoneNumber], completionHandler: @escaping (_ success:Bool, _ eventListRecords: [CKRecord]?, _ error:NSError?)->()) {
        let predicate = NSPredicate(format: "phoneNumber IN %@", argumentArray: [users])
        let query = CKQuery(recordType: userEventListRecordType, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, error) in
            if error != nil {
                // handle error
                completionHandler(false, nil, error as NSError?)
            } else if results?.count > 0 {
                completionHandler(true, results, nil)
            } else {
                completionHandler(false, nil, nil)
            }
        }
    }
    
    func updateUserEventList(_ eventList: EventList) {
        let recordID = CKRecordID(recordName: eventList.phoneNumber)
        let eventListRecord = CKRecord(recordType: userEventListRecordType, recordID: recordID)
        
        eventListRecord.setObject(eventList.phoneNumber as CKRecordValue?, forKey: "phoneNumber")
        eventListRecord.setObject(eventList.events as CKRecordValue?, forKey: "events")
        
        savePublicRecord(eventListRecord) { (success) in
            
        }
    }
    
    // MARK: Event
    
    /// Saves event to PublicDB, updates EventLists of each invitee with EventID
    func saveEvent(_ event: Event, completionHandler: (_ success: Bool, _ error: NSError?) -> ()) {
        let recordID = CKRecordID(recordName: event.ID)
        let eventRecord = CKRecord(recordType: eventRecordType, recordID: recordID)
        
        eventRecord.setObject(event.ID as CKRecordValue?, forKey: "id")
        eventRecord.setObject(event.name as CKRecordValue?, forKey: "name")
        eventRecord.setObject(event.location, forKey: "location")
        eventRecord.setObject(event.members as CKRecordValue?, forKey: "members")
        eventRecord.setObject(event.eventCreator as CKRecordValue?, forKey: "creator")
        eventRecord.setObject(event.dateCreated as CKRecordValue?, forKey: "dateCreated")
        eventRecord.setObject(event.eventWindoID as CKRecordValue?, forKey: "eventWindoID")
        eventRecord.setObject(event.memberWindoIDs as CKRecordValue?, forKey: "memberWindoIDs")
        eventRecord.setObject(event.possibleTimes as CKRecordValue?, forKey: "possibleTimes")
        
        savePublicRecord(eventRecord) { (success) in
            if success {
                self.updateEventMembersEventListsWithEventID(event.members, eventID: event.ID)
            } else {
                // handle failure
            }
        }
    }
    
    // MARK: CKRecord Parsing
    /// Takes CKRecord and returns User object
    fileprivate func parseUserRecord(_ userRecord: CKRecord) -> User {
        let id = userRecord.value(forKey: "userID") as! String
        let phoneNumber = userRecord.value(forKey: "phoneNumber") as! String
        let email = userRecord.value(forKey: "email") as! String
        let facebookID = userRecord.value(forKey: "facebookID") as! String
        let googleID = userRecord.value(forKey: "googleID") as! String
        let firstName = userRecord.value(forKey: "firstName") as! String
        let lastName = userRecord.value(forKey: "lastName") as! String
        let imageRecordID = userRecord.value(forKey: "imageRecordID") as! String
        let parsedUser = User(id: id, number: phoneNumber, email: email, facebookID: facebookID, googleID: googleID, firstName: firstName, lastName: lastName, imageRecordID: imageRecordID)
        return parsedUser
    }
    
    fileprivate func parseEventListRecord(_ eventListRecord: CKRecord) -> EventList {
        let phoneNumber = eventListRecord.object(forKey: "phoneNumber") as! String
        let events = eventListRecord.object(forKey: "events") as! [String]
        let eventList = EventList(phoneNumber: phoneNumber, events: events)
        return eventList
    }
    
    // MARK: Utility
    fileprivate func savePublicRecord(_ record: CKRecord, completionHandler: @escaping (_ success: Bool) -> ()) {
        publicDB.save(record, completionHandler: { savedRecord, error in
            if error != nil {
                print("failed to save record \n \(error)")
            } else {
                completionHandler(true)
            }
        })
    }
    
    fileprivate func savePrivateRecord(_ record: CKRecord, completionHandler: @escaping (_ success: Bool) -> ()) {
        privateDB.save(record, completionHandler: { savedRecord, error in
            if error != nil {
                print("failed to save record \n \(error)")
            } else {
                completionHandler(true)
            }
        })
    }
}

//
//  CloudManager.swift
//  Windo
//
//  Created by Joey on 7/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CloudKit

class CloudManager: NSObject {
    
    static let sharedManager = CloudManager()
    var defaultContainer = CKContainer.defaultContainer()
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase
    let privateDB = CKContainer.defaultContainer().privateCloudDatabase
    
    let userRecordType = "User"
    let userEventListRecordType = "UserEventList"
    let eventRecordType = "Event"
    let windoRecordType = "Windo"
    let messageRecordType = "Message"
    
    typealias PhoneNumber = String
    
    func requestPermission(completionHandler: (granted: Bool) -> ()) {
        defaultContainer.requestApplicationPermission(CKApplicationPermissions.UserDiscoverability, completionHandler: { applicationPermissionStatus, error in
            if applicationPermissionStatus == CKApplicationPermissionStatus.Granted {
                completionHandler(granted: true)
            } else {
                completionHandler(granted: false)
            }
        })
    }
    
    // MARK: User
    func getUser(completionHandler: (success: Bool, user: User?) -> ()) {
        getUserFromDefaults { (success, defaultsUser) in
            if success {
                completionHandler(success: true, user: defaultsUser)
            } else {
                self.getUserFromCloud({ (success, cloudUser) in
                    if success {
                        completionHandler(success: true, user: cloudUser)
                    } else {
                        completionHandler(success: false, user: nil)
                    }
                })
            }
        }
    }
    
    /// Will return user object if stored in NSUserDefaults
    func getUserFromDefaults(completionHandler: (success: Bool, user: User?) -> ()) {
        if let userData = NSUserDefaults.standardUserDefaults().objectForKey(Constants.userDefaultKeys.kUser) as? NSData {
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as! User
            completionHandler(success: true, user: user)
        } else {
            completionHandler(success: false, user: nil)
        }
    }
    
    /// Will return User object from iCloud if user has already created account, if successful user is saved in defaults
    func getUserFromCloud(completionHandler: (success: Bool, user: User?) -> ()) {
        defaultContainer.fetchUserRecordIDWithCompletionHandler { (userRecordID, error) in
            if error != nil {
                // iCloud error
                completionHandler(success: false, user: nil)
            } else {
                let predicate = NSPredicate(format: "userID == '\(userRecordID!.recordName)'")
                let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
                self.privateDB.performQuery(query, inZoneWithID: nil) { user, error in
                    if error != nil {
                        print("failed to fetch user \n \(error)")
                        completionHandler(success: false, user: nil)
                    } else {
                        // create User from CKRecord
                        if let userRecord = user?.first {
                            let fetchedUser = self.parseUserRecord(userRecord)
                            self.storeUserInDefaults(fetchedUser)
                            completionHandler(success: true, user: fetchedUser)
                        }
                    }
                }
            }
        }
    }
    
    /// Stores user object in iCloud and, if successful, saves it to UserDefaults
    func saveNewUser(user: User, completionHandler: (user: User?,success: Bool) -> ()) {
        defaultContainer.fetchUserRecordIDWithCompletionHandler { (appleUserRecordID, error) in
            if error != nil {
                // handle error
                completionHandler(user: nil, success: false)
            } else {
                let recordID = CKRecordID(recordName: user.phoneNumber)
                let userRecord = CKRecord(recordType: self.userRecordType, recordID: recordID)
                user.recordID = appleUserRecordID?.recordName
                
                userRecord.setObject(user.recordID, forKey: "userID")
                userRecord.setObject(user.phoneNumber, forKey: "phoneNumber")
                userRecord.setObject(user.firstName, forKey: "firstName")
                userRecord.setObject(user.lastName, forKey: "lastName")
                userRecord.setObject(user.email, forKey: "email")
                userRecord.setObject(user.facebookID, forKey: "facebookID")
                userRecord.setObject(user.googleID, forKey: "googleID")
                userRecord.setObject(user.imageRecordID, forKey: "imageRecordID")
                
                self.savePrivateRecord(userRecord, completionHandler: { (success) in
                    if success {
                        self.storeUserInDefaults(user)
                        completionHandler(user: user, success: true)
                    } else {
                        // handle failure
                        completionHandler(user: nil, success: false)
                    }
                })
            }
        }
    }
    
    func storeUserInDefaults(user: User) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Constants.userDefaultKeys.kUser)
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
    
    func updateEventMembersEventListsWithEventID(users: [PhoneNumber], eventID: String) {
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
    func updateExistingEventListsWithEventID(users: [PhoneNumber], eventID: String, completionHandler: (success:Bool, eventListsToCreate: [PhoneNumber]?, error: NSError?)->()) {
        
        var usersWithoutEventLists = users
        getExistingEventListRecordsWithUserList(users) { (success, eventListRecords, error) in
            if error != nil {
                //handle error
            } else if eventListRecords?.count > 0 {
                for record in eventListRecords! {
                    let eventList = self.parseEventListRecord(record)
                    self.updateUserEventList(eventList)
                    usersWithoutEventLists.removeAtIndex(usersWithoutEventLists.indexOf(eventList.phoneNumber)!)
                }
                
                completionHandler(success: true, eventListsToCreate: usersWithoutEventLists, error: error)
            }
        }
        
    }
    
    func getExistingEventListRecordsWithUserList(users: [PhoneNumber], completionHandler: (success:Bool, eventListRecords: [CKRecord]?, error:NSError?)->()) {
        let predicate = NSPredicate(format: "phoneNumber IN %@", argumentArray: [users])
        let query = CKQuery(recordType: userEventListRecordType, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error != nil {
                // handle error
                completionHandler(success: false, eventListRecords: nil, error: error)
            } else if results?.count > 0 {
                completionHandler(success: true, eventListRecords: results, error: nil)
            } else {
                completionHandler(success: false, eventListRecords: nil, error: nil)
            }
        }
    }
    
    func updateUserEventList(eventList: EventList) {
        let recordID = CKRecordID(recordName: eventList.phoneNumber)
        let eventListRecord = CKRecord(recordType: userEventListRecordType, recordID: recordID)
        
        eventListRecord.setObject(eventList.phoneNumber, forKey: "phoneNumber")
        eventListRecord.setObject(eventList.events, forKey: "events")
        
        savePublicRecord(eventListRecord) { (success) in
            
        }
    }
    
    // MARK: Event
    
    /// Saves event to PublicDB, updates EventLists of each invitee with EventID
    func saveEvent(event: Event, completionHandler: (success: Bool, error: NSError?) -> ()) {
        let recordID = CKRecordID(recordName: event.ID)
        let eventRecord = CKRecord(recordType: eventRecordType, recordID: recordID)
        
        eventRecord.setObject(event.ID, forKey: "id")
        eventRecord.setObject(event.name, forKey: "name")
        eventRecord.setObject(event.location, forKey: "location")
        eventRecord.setObject(event.members, forKey: "members")
        eventRecord.setObject(event.eventCreator, forKey: "creator")
        eventRecord.setObject(event.dateCreated, forKey: "dateCreated")
        eventRecord.setObject(event.eventWindoID, forKey: "eventWindoID")
        eventRecord.setObject(event.memberWindoIDs, forKey: "memberWindoIDs")
        eventRecord.setObject(event.possibleTimes, forKey: "possibleTimes")
        
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
    private func parseUserRecord(userRecord: CKRecord) -> User {
        let id = userRecord.valueForKey("userID") as! String
        let phoneNumber = userRecord.valueForKey("phoneNumber") as! String
        let email = userRecord.valueForKey("email") as! String
        let facebookID = userRecord.valueForKey("facebookID") as! String
        let googleID = userRecord.valueForKey("googleID") as! String
        let firstName = userRecord.valueForKey("firstName") as! String
        let lastName = userRecord.valueForKey("lastName") as! String
        let imageRecordID = userRecord.valueForKey("imageRecordID") as! String
        let parsedUser = User(id: id, number: phoneNumber, email: email, facebookID: facebookID, googleID: googleID, firstName: firstName, lastName: lastName, imageRecordID: imageRecordID)
        return parsedUser
    }
    
    private func parseEventListRecord(eventListRecord: CKRecord) -> EventList {
        let phoneNumber = eventListRecord.objectForKey("phoneNumber") as! String
        let events = eventListRecord.objectForKey("events") as! [String]
        let eventList = EventList(phoneNumber: phoneNumber, events: events)
        return eventList
    }
    
    // MARK: Utility
    private func savePublicRecord(record: CKRecord, completionHandler: (success: Bool) -> ()) {
        publicDB.saveRecord(record, completionHandler: { savedRecord, error in
            if error != nil {
                print("failed to save record \n \(error)")
            } else {
                completionHandler(success: true)
            }
        })
    }
    
    private func savePrivateRecord(record: CKRecord, completionHandler: (success: Bool) -> ()) {
        privateDB.saveRecord(record, completionHandler: { savedRecord, error in
            if error != nil {
                print("failed to save record \n \(error)")
            } else {
                completionHandler(success: true)
            }
        })
    }
}

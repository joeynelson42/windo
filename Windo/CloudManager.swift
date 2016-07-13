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
    
    /// Will return User object from iCloud if user has already created account
    func getUserFromCloud(completionHandler: (success: Bool, user: User?) -> ()) {
        defaultContainer.fetchUserRecordIDWithCompletionHandler { (userRecordID, error) in
            if error != nil {
                // iCloud error
                completionHandler(success: false, user: nil)
            } else {
                let predicate = NSPredicate(format: "userID CONTAINS '\(userRecordID!.recordName)'")
                let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
                self.privateDB.performQuery(query, inZoneWithID: nil) { user, error in
                    if error != nil {
                        print("failed to fetch user \n \(error)")
                        completionHandler(success: false, user: nil)
                    } else {
                        // create User from CKRecord
                        if let userRecord = user?.first {
                            let fetchedUser = self.parseUserRecord(userRecord)
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
                        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
                        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Constants.userDefaultKeys.kUser)
                        completionHandler(user: user, success: true)
                    } else {
                        // handle failure
                        completionHandler(user: nil, success: false)
                    }
                })
            }
        }
    }
    
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

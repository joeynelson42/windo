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
    
    
    
//    func getUser(completionHandler: (success: Bool, user: User?) -> ()) {
//        defaultContainer.fetchUserRecordIDWithCompletionHandler { (userRecordID, error) in
//            if error != nil {
//                completionHandler(success: false, user: nil)
//            } else {
//                let privateDatabase = self.defaultContainer.privateCloudDatabase
//                privateDatabase.fetchRecordWithID(userRecordID!, completionHandler: { (user: CKRecord?, anError) -> Void in
//                    if (error != nil) {
//                        completionHandler(success: false, user: nil)
//                    } else {
//                        let user = User(userRecordID: userRecordID!)
//                        completionHandler(success: true, user: user)
//                    }
//                })
//            }
//        }
//    }
//    
//    func getUserInfo(user: User, completionHandler: (success: Bool, user: User?) -> ()) {
//        defaultContainer.discoverUserInfoWithUserRecordID(user.userRecordID) { (info, fetchError) in
//            if fetchError != nil {
//                completionHandler(success: false, user: nil)
//            } else {
//                user.firstName = info!.displayContact!.givenName
//                user.lastName = info!.displayContact!.familyName
//                completionHandler(success: true, user: user)
//            }
//        }
//    }
//    
//    // MARK: Passwords
//    func savePassword(password: Password, completionHandler: (success: Bool) -> ()) {
//        let timestampAsString = String(format: "%f", NSDate.timeIntervalSinceReferenceDate())
//        let timestampParts = timestampAsString.componentsSeparatedByString(".")
//        
//        let recordID = CKRecordID(recordName: "\(timestampParts[0])")
//        let passwordRecord = CKRecord(recordType: passwordsRecordType, recordID: recordID)
//        
//        passwordRecord.setObject(password.userID, forKey: "userID")
//        passwordRecord.setObject(password.password, forKey: "password")
//        passwordRecord.setObject(password.title, forKey: "title")
//        passwordRecord.setObject(password.username, forKey: "username")
//        passwordRecord.setObject(password.note, forKey: "note")
//        passwordRecord.setObject(password.timestamp, forKey: "timestamp")
//        
//        saveRecord(passwordRecord, completionHandler: completionHandler)
//    }
//    
//    func getUserPasswords(user: User, completionHandler: (success: Bool, passwords: [Password]?) -> ()) {
//        
//        let predicate = NSPredicate(format: "userID CONTAINS '\(user.userRecordID.recordName)'")
//        let query = CKQuery(recordType: passwordsRecordType, predicate: predicate)
//        
//        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
//            if error != nil {
//                print("failed to fetch passwords \n \(error)")
//            } else {
//                print(results)
//            }
//        }
//    }
//    
//    // MARK: Confidants
//    func saveConfidants(confiding: Confiding, completionHandler: (success: Bool) -> ()) {
//        let timestampAsString = String(format: "%f", NSDate.timeIntervalSinceReferenceDate())
//        let timestampParts = timestampAsString.componentsSeparatedByString(".")
//        
//        let recordID = CKRecordID(recordName: "\(confiding.userID) \(timestampParts[0])")
//        let confidantsRecord = CKRecord(recordType: confidantsRecordType, recordID: recordID)
//        
//        confidantsRecord.setValue(confiding.userID, forKey: "userID")
//        confidantsRecord.setValue(confiding.confidants, forKey: "confidants")
//        
//        saveRecord(confidantsRecord, completionHandler: completionHandler)
//    }
    
    // MARK: Utility
    private func saveRecord(record: CKRecord, completionHandler: (success: Bool) -> ()) {
        publicDB.saveRecord(record, completionHandler: { savedRecord, error in
            if error != nil {
                print("failed to save password \n \(error)")
            } else {
                completionHandler(success: true)
            }
        })
    }
}

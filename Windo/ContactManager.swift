//
//  ContactManager.swift
//  Windo
//
//  Created by Joey Nelson on 7/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Contacts

class ContactManager {
    
    static let sharedManager = ContactManager()
    let store = CNContactStore()
    var contacts = [Invitee]()
    
    func sync(completionHandler: (success: Bool) -> ()) {
        self.requestAccess { (success) in
            if success {
                if let _ = self.fetchContactsFromDefaults() {
                    print("successfully retrieved contacts from defaults")
                    completionHandler(success: true)
                } else {
                    self.fetchInviteesWithCompletion({ (invitees, success) in
                        if success{
                            print("successfully retrieved contacts and stored them in defaults")
                            self.storeContacts(invitees)
                            completionHandler(success: true)
                        }
                    })
                }
            } else {
                print("failed to fetch contacts")
                completionHandler(success: false)
            }
        }
    }
    
    func requestAccess(completionHandler: (success: Bool) -> ()) {
        let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
        if status == .Authorized {
            completionHandler(success: true)
        } else if status == .Denied || status == .Restricted {
            completionHandler(success: false)
        } else {
            store.requestAccessForEntityType(.Contacts) { (success, error) in
                if error != nil {
                    // handle error
                } else {
                    // success!
                }
                
                completionHandler(success: success)
            }
        }
    }
    
    func fetchInviteesWithCompletion(completion:(invitees: [Invitee], success: Bool)->()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let contacts = ContactManager.sharedManager.fetchContacts() {
                let invitees = ContactManager.sharedManager.getInviteesFromContacts(contacts)
                dispatch_async(dispatch_get_main_queue()) {
                    completion(invitees: invitees, success: true)
                }
            } else {
                completion(invitees: [], success: false)
            }
        }
    }
    
    private func fetchContacts() -> [CNContact]? {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest) { (contact, nil) in
                contacts.append(contact)
            }
            
            return contacts
        } catch {
            // handle fetch error
            return nil
        }
    }
    
    private func getInviteesFromContacts(contacts: [CNContact]) -> [Invitee] {
        var invitees = [Invitee]()
        
        for contact in contacts {
            if contact.phoneNumbers.count <= 0 {
                break
            }
            
            guard let number = contact.phoneNumbers[0].value as? CNPhoneNumber else { break }
            let newInvitee = Invitee(number: number.stringValue, firstName: contact.givenName, lastName: contact.familyName)
            invitees.append(newInvitee)
        }
        
        self.contacts = invitees
        
        return invitees
    }
    
    // MARK: UserDefaults
    
    func storeContacts(contacts: [Invitee]) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(contacts)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Constants.userDefaultKeys.kContacts)
    }
    
    func fetchContactsFromDefaults() -> [Invitee]?{
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey(Constants.userDefaultKeys.kContacts) as? NSData else { return nil }
        guard let contacts = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Invitee] else { return nil }
        self.contacts = contacts
        return contacts
    }
}
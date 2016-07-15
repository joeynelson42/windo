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
            guard let number = contact.phoneNumbers.first!.value as? String,
                    let firstName = contact.givenName as? String,
                    let lastName = contact.familyName as? String
                else { return [] }
            
            let newInvitee = Invitee(number: number, firstName: firstName, lastName: lastName)
            invitees.append(newInvitee)
        }
        
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
        return contacts
    }
}
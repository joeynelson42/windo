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
    
    func fetchContacts() -> [CNContact] {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest) { (contact, nil) in
                contacts.append(contact)
            }
        } catch {
            // handle fetch error
        }
        
        return contacts
    }
    
    
    // not sure if this will be necessary...we'll see how long it really takes to fetch contacts
    func fetchContactsFromUserDefaults() {
        
    }
    
    func getInviteesFromContacts(contacts: [CNContact]) -> [Invitee] {
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
}
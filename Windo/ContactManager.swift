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
    
    func sync(_ completionHandler: @escaping (_ success: Bool) -> ()) {
        self.requestAccess { (success) in
            if success {
                if let _ = self.fetchContactsFromDefaults() {
                    print("successfully retrieved contacts from defaults")
                    completionHandler(true)
                } else {
                    self.fetchInviteesWithCompletion({ (invitees, success) in
                        if success{
                            print("successfully retrieved contacts and stored them in defaults")
                            self.storeContacts(invitees)
                            completionHandler(true)
                        }
                    })
                }
            } else {
                print("failed to fetch contacts")
                completionHandler(false)
            }
        }
    }
    
    func requestAccess(_ completionHandler: @escaping (_ success: Bool) -> ()) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .authorized {
            completionHandler(true)
        } else if status == .denied || status == .restricted {
            completionHandler(false)
        } else {
            store.requestAccess(for: .contacts) { (success, error) in
                if error != nil {
                    // handle error
                } else {
                    // success!
                }
                
                completionHandler(success)
            }
        }
    }
    
    func fetchInviteesWithCompletion(_ completion:@escaping (_ invitees: [Invitee], _ success: Bool)->()) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            if let contacts = ContactManager.sharedManager.fetchContacts() {
                let invitees = ContactManager.sharedManager.getInviteesFromContacts(contacts)
                DispatchQueue.main.async {
                    completion(invitees, true)
                }
            } else {
                completion([], false)
            }
        }
    }
    
    fileprivate func fetchContacts() -> [CNContact]? {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContacts(with: fetchRequest) { (contact, nil) in
                contacts.append(contact)
            }
            
            return contacts
        } catch {
            // handle fetch error
            return nil
        }
    }
    
    fileprivate func getInviteesFromContacts(_ contacts: [CNContact]) -> [Invitee] {
        var invitees = [Invitee]()
        
        for contact in contacts {
            if contact.phoneNumbers.count <= 0 {
                break
            }
            
            guard let number = contact.phoneNumbers.first?.value else { break }
            let newInvitee = Invitee(number: number.stringValue, firstName: contact.givenName, lastName: contact.familyName)
            invitees.append(newInvitee)
        }
        
        self.contacts = invitees
        
        return invitees
    }
    
    // MARK: UserDefaults
    
    func storeContacts(_ contacts: [Invitee]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: contacts)
        UserDefaults.standard.set(data, forKey: Constants.userDefaultKeys.kContacts)
    }
    
    func fetchContactsFromDefaults() -> [Invitee]?{
        guard let data = UserDefaults.standard.object(forKey: Constants.userDefaultKeys.kContacts) as? Data else { return nil }
        guard let contacts = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Invitee] else { return nil }
        self.contacts = contacts
        return contacts
    }
}

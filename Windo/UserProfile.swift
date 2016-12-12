//
//  UserProfile.swift
//  Windo
//
//  Created by Joey Nelson on 6/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class UserProfile: NSObject {
    var id: String //Firebase
    var fbID: String //Facebook
    var firstName: String
    var lastName: String
    var profilePictureURL: String
    var email: String
    
    override init() {
        id = ""
        fbID = ""
        firstName = ""
        lastName = ""
        profilePictureURL = ""
        email = ""
    }
    
    init(firebaseID: String, facebookID: String, first: String, last: String, url: String, email: String) {
        id = firebaseID
        fbID = facebookID
        firstName = first
        lastName = last
        profilePictureURL = url
        self.email = email
    }
    
    var fullName: String {
        if firstName == "" || lastName == "" {
            return ""
        } else {
            return "\(firstName) \(lastName)"
        }
    }
    
    func getInitials() -> String{
        let name = fullName
        if fullName.isEmpty {
            return ""
        }
        
        let firstInitial = "\(name[name.characters.index(name.startIndex, offsetBy: 0)])"
        
        guard let index = name.characters.index(of: " ") else {
            return firstInitial.uppercased()
        }
        
        let secondInitial = "\(name[name.characters.index(name.startIndex, offsetBy: name.characters.distance(from: name.startIndex, to: index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercased()
    }
    
    func profilePicture() -> UIImage? {
        guard let data = try? Data(contentsOf: URL(string: profilePictureURL)!) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    //MARK: Coding
    
    required convenience init?(coder decoder: NSCoder) {
        guard   let id = decoder.decodeObject(forKey: "id") as? String,
                let fbID = decoder.decodeObject(forKey: "fbID") as? String,
                let first = decoder.decodeObject(forKey: "firstName") as? String,
                let last = decoder.decodeObject(forKey: "lastName") as? String,
                let url = decoder.decodeObject(forKey: "url") as? String,
                let email = decoder.decodeObject(forKey: "email") as? String
            else { return nil }
        
        self.init(
            firebaseID: id,
            facebookID: fbID,
            first: first,
            last: last,
            url: url,
            email: email
        )
    }
    
    func encodeWithCoder(_ coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.fbID, forKey: "fbID")
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.profilePictureURL, forKey: "url")
        coder.encode(self.email, forKey: "email")
    }
}

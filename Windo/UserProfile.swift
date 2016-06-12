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
    var friends: [UserProfile]
    
    override init() {
        id = ""
        fbID = ""
        firstName = ""
        lastName = ""
        profilePictureURL = ""
        email = ""
        friends = []
    }
    
    init(firebaseID: String, facebookID: String, first: String, last: String, url: String, email: String, friendList: [UserProfile]) {
        id = firebaseID
        fbID = facebookID
        firstName = first
        lastName = last
        profilePictureURL = url
        self.email = email
        friends = friendList
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func profilePicture() -> UIImage? {
        guard let data = NSData(contentsOfURL: NSURL(string: profilePictureURL)!) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    //MARK: Coding
    
    required convenience init?(coder decoder: NSCoder) {
        guard   let id = decoder.decodeObjectForKey("id") as? String,
                let fbID = decoder.decodeObjectForKey("fbID") as? String,
                let first = decoder.decodeObjectForKey("firstName") as? String,
                let last = decoder.decodeObjectForKey("lastName") as? String,
                let url = decoder.decodeObjectForKey("url") as? String,
                let email = decoder.decodeObjectForKey("email") as? String,
                let friends = decoder.decodeObjectForKey("friends") as? [UserProfile]
            else { return nil }
        
        self.init(
            firebaseID: id,
            facebookID: fbID,
            first: first,
            last: last,
            url: url,
            email: email,
            friendList: friends
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.fbID, forKey: "fbID")
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.profilePictureURL, forKey: "url")
        coder.encodeObject(self.email, forKey: "email")
        coder.encodeObject(self.friends, forKey: "friends")
    }
}
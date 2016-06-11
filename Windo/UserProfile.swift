//
//  UserProfile.swift
//  Windo
//
//  Created by Joey Nelson on 6/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class UserProfile: NSObject {
    var firstName: String
    var lastName: String
    var profilePictureURL: String
    var email: String
    var friendList: [UserProfile]
    
    override init() {
        firstName = ""
        lastName = ""
        profilePictureURL = ""
        email = ""
        friendList = []
    }
    
    init(first: String, last: String, url: String, email: String, friends: [UserProfile]) {
        firstName = first
        lastName = last
        profilePictureURL = url
        self.email = email
        friendList = friends
    }
    
    func profilePicture() -> UIImage? {
        guard let data = NSData(contentsOfURL: NSURL(string: profilePictureURL)!) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    //MARK: Coding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let first = decoder.decodeObjectForKey("firstName") as? String,
                let last = decoder.decodeObjectForKey("lastName") as? String,
                let url = decoder.decodeObjectForKey("url") as? String,
                let email = decoder.decodeObjectForKey("email") as? String,
                let friends = decoder.decodeObjectForKey("friendsList") as? NSArray
            else { return nil }
        
//        let friendArray = [UserProfile]()
//        for friend in friends {
//            if let
//        }
     
        self.init(
            first: first,
            last: last,
            url: url,
            email: email
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.profilePictureURL, forKey: "url")
        coder.encodeObject(self.email, forKey: "email")
    }
}
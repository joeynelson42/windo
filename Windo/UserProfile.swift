//
//  UserProfile.swift
//  Windo
//
//  Created by Joey Nelson on 6/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class UserInfo: NSObject {
    var firstName: String
    var lastName: String
    var profilePictureURL: String
    var profilePictureLocalPath: String
    
    init(first: String, last: String, url: String, localPath: String) {
        firstName = first
        lastName = last
        profilePictureURL = url
        profilePictureLocalPath = localPath
    }
    
    //MARK: Coding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let first = decoder.decodeObjectForKey("firstName") as? String,
                let last = decoder.decodeObjectForKey("lastName") as? String,
                let url = decoder.decodeObjectForKey("url") as? String,
                let localPath = decoder.decodeObjectForKey("localPath") as? String
            else { return nil }
     
        self.init(
            first: first,
            last: last,
            url: url,
            localPath: localPath
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.profilePictureURL, forKey: "url")
        coder.encodeObject(self.profilePictureLocalPath, forKey: "localPath")
    }
}
//
//  DataProvider.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseDatabase
import FirebaseAuth

class DataProvider {
    
    static let sharedProvider = DataProvider()
//    let dbRef = FIRDatabase.database().reference()

    // PATHS
    let userPath = "users"
    let eventPath = "events"
    let windoPath = "windos"
    
    // MARK: User
    // TODO: 
    
    func fetchUserProfileFromFacebook() {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), friends"])
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            request.startWithCompletionHandler({ (connection, result, error) in
                
                if let e = error {
                    print(e)
                    return
                }
                
                let info = result as! NSDictionary
                
                if let id = FIRAuth.auth()?.currentUser?.uid {
                    UserManager.userProfile.id = id
                }
                
                if let fbID = info.valueForKey("id") as? String {
                    UserManager.userProfile.fbID = fbID
                }
                
                if let firstName = info.valueForKey("first_name") as? String {
                    UserManager.userProfile.firstName = firstName
                }
                
                if let lastName = info.valueForKey("last_name") as? String {
                    UserManager.userProfile.lastName = lastName
                }
                
                if let email = info.valueForKey("email") as? String {
                    UserManager.userProfile.email = email
                }
                
                if let friendsData = info.valueForKey("friends") as? NSDictionary {
                    UserManager.userProfile.friends = DataProvider.sharedProvider.fetchUserFriends(friendsData)
                }
                
                if let imageURL = info.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String {
                    UserManager.userProfile.profilePictureURL = imageURL
                }
                
                let userData = NSKeyedArchiver.archivedDataWithRootObject(UserManager.userProfile)
                NSUserDefaults.standardUserDefaults().setObject(userData, forKey: kUserProfile)
            })
        }
    }
 
//    func fetchCurrentUserProfilePicture() {
//        let imageURL = UserManager.userProfile.profilePictureURL
//        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: imageURL)!, completionHandler: { (data, response, error) -> Void in
//            guard
//                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
//                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
//                let data = data where error == nil
//                else { return }
//        
//            
//        }).resume()
//    }
    
    func fetchUserFriends(data: NSDictionary) -> [UserProfile] {
        var friends = [UserProfile]()
        if let friendsList = data.objectForKey("data") as? NSArray {
            for friend in friendsList {
                if let id = friend.valueForKey("id") as? String {
                    friends.append(self.fetchFriendProfile(id))
                }
            }
        }
        return friends
    }
    
    func fetchFriendProfile(id: String) -> UserProfile {
        let friend = UserProfile()
        let request = FBSDKGraphRequest(graphPath: id, parameters: ["fields": kFriendFBFields])
        request.startWithCompletionHandler({ (connection, result, error) in
            let info = result as! NSDictionary
            
            if let firstName = info.valueForKey("first_name") as? String {
                friend.firstName = firstName
            }
            
            if let lastName = info.valueForKey("last_name") as? String {
                friend.lastName = lastName
            }
            
            if let email = info.valueForKey("email") as? String {
                friend.email = email
            }
            
            if let imageURL = info.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String {
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: imageURL)!, completionHandler: { (data, response, error) -> Void in
                    guard
                        let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                        let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                        let data = data where error == nil
                        else { return }
                    
                    data.writeToURL(NSURL(string: imageURL)!, atomically: true)
                    
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        friend.profilePictureURL = imageURL
                    }
                }).resume()
            }
        })
        
        return friend
    }
    
    func uploadUser(user: UserProfile) {
        // TODO: create a User object from Profile
//        let userObject = User()
//        
//        dbRef.child(userPath).child(user.id).setValue(userObject)
    }
    
    // MARK: Events
//    func createEvent(newEvent: Event) {
////        self.dbRef.child(eventPath).child(newEvent.ID).setValue(newEvent)
//        for member in newEvent.members {
////            let userID = member.ID
////            dbRef.child(userPath).child(userID).child("eventIDs").child(newEvent.ID).setValue(ResponseStatus.NeedsResponse.rawValue)
//        }
//    }
//    
//    func getEventByID(ID: String) -> Event {
//        let event = Event()
//        
//        
////        let recentPostsQuery = (dbRef.child(eventPath).queryEqualToValue(AnyObject?))
//        
//        return event
//    }

    
    
    
    
    
}
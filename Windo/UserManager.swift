//
//  UserManager.swift
//  Windo
//
//  Created by Joey on 6/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class UserManager {
    
    static let sharedManager = UserManager()
    static var userProfile = UserProfile()
    
    func userIsLoggedIn() -> Bool {
        if let _ = FIRAuth.auth()?.currentUser {
            return true
        } else {
            return false
        }
    }
    
    func signOut() {
        
        try! FIRAuth.auth()!.signOut()
        
        if let _ = FIRAuth.auth()?.currentUser {
            return
        } else {
            let rootVC = LoginViewController()
            
            print("sign out hit")
            
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }
    }
    
    func fetchUserProfile() {
//        if fetchUserProfileFromDefaults() {
//            return
//        } else {
            fetchUserProfileFromFacebook()
//        }
    }
    
    func fetchUserProfileFromFacebook() {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), friends"])
        request.startWithCompletionHandler({ (connection, result, error) in
            let info = result as! NSDictionary
            
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
                if let friendsList = friendsData.objectForKey("data") as? NSArray {
                    for friend in friendsList {
                        if let id = friend.valueForKey("id") as? String {
                            self.fetchFriendProfile(id)
                        }
                    }
                }

                
                
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
                        UserManager.userProfile.profilePictureURL = imageURL
                        let userData = NSKeyedArchiver.archivedDataWithRootObject(UserManager.userProfile)
                        NSUserDefaults.standardUserDefaults().setObject(userData, forKey: kUserProfile)
                    }
                }).resume()
            }
        })
    }
    
    func fetchUserProfileFromDefaults() -> Bool {
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey(kUserProfile) as? NSData else { return false }
        guard let userProfile = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserProfile else { return false }
        UserManager.userProfile = userProfile
        return true
    }
    
    // MARK: Facebook
    
//    func removeFbData() {
//        //Remove FB Data
//        let fbManager = FBSDKLoginManager()
//        fbManager.logOut()
//        FBSDKAccessToken.setCurrentAccessToken(nil)
//    }
    
    func fbLogin(didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            // Successful login
            
            fetchUserProfile()
            
            // Firebase Login
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                //fetch user's events and open home screen on completion
                let rootVC = ContainerViewController()
                let window = UIApplication.sharedApplication().delegate!.window!
                window!.rootViewController = rootVC
                window!.makeKeyAndVisible()
            }
        }
    }
    
    func fbLogout() {
        try! FIRAuth.auth()!.signOut()
        
        let rootVC = LoginViewController()
        let window = UIApplication.sharedApplication().delegate!.window!
        window!.rootViewController = rootVC
        window!.makeKeyAndVisible()
    }
    
    func fetchUserFriends(friendIDs: NSArray, options: String) {
        
        
        
    }
    
    // TODO: Figure out how to store friend profiles
    func fetchFriendProfile(id: String) {
        let request = FBSDKGraphRequest(graphPath: id, parameters: ["fields": kFriendFBFields])
        request.startWithCompletionHandler({ (connection, result, error) in
            let info = result as! NSDictionary
            
            if let firstName = info.valueForKey("first_name") as? String {
                UserManager.userProfile.firstName = firstName
            }
            
            if let lastName = info.valueForKey("last_name") as? String {
                UserManager.userProfile.lastName = lastName
            }
            
            if let email = info.valueForKey("email") as? String {
                UserManager.userProfile.email = email
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
                        UserManager.userProfile.profilePictureURL = imageURL
                        let userData = NSKeyedArchiver.archivedDataWithRootObject(UserManager.userProfile)
                        NSUserDefaults.standardUserDefaults().setObject(userData, forKey: kUserProfile)
                    }
                }).resume()
            }
        })
    }
    
    
}
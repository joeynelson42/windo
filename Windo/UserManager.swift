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
    static var friends = [UserProfile]()
    
    func userIsLoggedIn() -> Bool {
        if let _ = FIRAuth.auth()?.currentUser {
            return true
        } else {
            return false
        }
    }
    
    func login() {
        // Firebase Login
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential, completion: nil)
    }
    
    func loginAndLoadHomeScreen() {
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
    
    func signOut() {
        try! FIRAuth.auth()!.signOut()

        if let _ = FIRAuth.auth()?.currentUser {
            return
        } else {
            let rootVC = LoginViewController()
            print("sign out hit")
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
            NSUserDefaults.standardUserDefaults().setPersistentDomain(["":""], forName: NSBundle.mainBundle().bundleIdentifier!)
            
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }
    }
    
    func fetchUserProfile() {
        if fetchUserProfileFromDefaults() {
            return
        } else {
            DataProvider.sharedProvider.fetchUserProfileFromFacebook()
        }
    }
    
    func fetchUserProfileFromDefaults() -> Bool {
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey(kUserProfile) as? NSData else { return false }
        guard let userProfile = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserProfile else { return false }
        
        guard let friendData = NSUserDefaults.standardUserDefaults().objectForKey("friends") as? NSData else { return false }
        guard let friendsArray = NSKeyedUnarchiver.unarchiveObjectWithData(friendData) as? [UserProfile] else { return false }
        
        UserManager.userProfile = userProfile
        UserManager.friends = friendsArray
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
            self.loginAndLoadHomeScreen()
        }
    }
    
    func fbLogout() {
        try! FIRAuth.auth()!.signOut()
        
        let rootVC = LoginViewController()
        let window = UIApplication.sharedApplication().delegate!.window!
        window!.rootViewController = rootVC
        window!.makeKeyAndVisible()
    }
    
   
    
    
    
    
}
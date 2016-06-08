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
    
    func userIsLoggedIn() -> Bool {
        if let user = FIRAuth.auth()?.currentUser {
            return true
        } else {
            return false
        }
    }
    
    func signOut() {
        
        try! FIRAuth.auth()!.signOut()
        
        if let user = FIRAuth.auth()?.currentUser {
            return
        } else {
            let rootVC = LoginViewController()
            
            print("sign out hit")
            
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }

    }
    
    // MARK: Facebook login methods for custom button
    
    func fbLoginInitiate() {
        let loginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], handler: {(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if (error != nil) {
                self.removeFbData()
            } else if result.isCancelled {
                self.removeFbData()
            } else {
                //Success
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    return
                }
                
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(kUserLoggedIn, object: nil)
                
                if result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") {
                    //Do work
                    self.fetchFacebookProfile()
                } else {
                    // Handle error
                }
            }
        })
    }
    
    func removeFbData() {
        //Remove FB Data
        let fbManager = FBSDKLoginManager()
        fbManager.logOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    func fetchFacebookProfile()
    {
        if FBSDKAccessToken.currentAccessToken() != nil {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    //Handle error
                } else {
                    //Handle Profile Photo URL String
                    let userId =  result["id"] as! String
                    let profilePictureUrl = "https://graph.facebook.com/\(userId)/picture?type=large"
                    
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    let fbUser = ["accessToken": accessToken, "user": result]
                }
            })
        }
    }
}
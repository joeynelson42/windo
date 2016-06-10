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
    
    // MARK: Facebook
    
//    func removeFbData() {
//        //Remove FB Data
//        let fbManager = FBSDKLoginManager()
//        fbManager.logOut()
//        FBSDKAccessToken.setCurrentAccessToken(nil)
//    }
    
//    func fetchFacebookProfile()
//    {
//        if FBSDKAccessToken.currentAccessToken() != nil {
//            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
//            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//                
//                if ((error) != nil) {
//                    //Handle error
//                } else {
//                    //Handle Profile Photo URL String
//                    let userId =  result["id"] as! String
//                    let profilePictureUrl = "https://graph.facebook.com/\(userId)/picture?type=large"
//                    
//                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
//                    let fbUser = ["accessToken": accessToken, "user": result]
//                }
//            })
//        }
//    }
    
    func fbLogin(didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                
            }
            
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
}
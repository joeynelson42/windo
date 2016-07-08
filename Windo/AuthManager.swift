//
//  AuthManager.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class AuthManager {
    
    var code = ""
    
    func createAuthCode() {
        code = String.randomNumericString(6)
    }
    
    func verifyCode(userInput: String) -> Bool {
        if userInput == code {
            return true
        } else {
            return false
        }
    }
    
    func sendSMS(phoneNumber: String, completion: (success: Bool) -> ()){
        print(code)
        
//        let twilioSID = "ACd5031f1ce835074bdb6aeff04e7fba89"
//        let twilioSecret = "7ce7a349722b5867f426ffd916fd269f"
//        let fromNumber = "15622802894"
//        let toNumber = phoneNumber
//        let message = "Your Windo code is \(code)"
//        
//        let request = NSMutableURLRequest(URL: NSURL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
//        request.HTTPMethod = "POST"
//        request.HTTPBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//            print("Finished")
//            
//            if let data = data, responseDetails = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                print("Response: \(responseDetails)")
//                completion(success: true)
//            } else {
//                print("Error: \(error)")
//            }
//        }).resume()
    }
}
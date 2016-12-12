//
//  WindoConstants.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var keyboardHeight: CGFloat = 216

let phoneInputCharacterSize = (screenWidth * 0.0775)

let timeSelectSize: CGFloat = (screenWidth)/7.5
let eventNameMaxLength: Int = 25
let centerPanelExpandedOffset: CGFloat = 75

let idLength = 12

let fbPermissions = ["public_profile", "email", "user_friends"]

let kFriendFBFields = "id, name, first_name, last_name, email, picture.type(large)"

let kUserLoggedIn = "userLoggedIn"
let kUserInfoReceived = "userInfoReceived"
let kUserProfile = "userProfile"

// MARK: Notifications
let ProfileImageReadyNotification = "ProfileImageReady"



struct Constants {
    struct userDefaultKeys {
        static let kUserPhoneNumber = "userPhoneNumber"
        static let kUser = "user"
        static let kContacts = "contacts"
    }
    
    struct notifications {
        static let firstNameWasChanged = "usernameWasChanged"
        static let lastNameWasChanged = "lastNameWasChanged"
        static let phoneNumberWasChanged = "phoneNumberWasChanged"
        static let emailWasChanged = "emailWasChanged"
    }
}


/*
 here is the simple fix to VENToken.m that made our color scheme work
 TODO: Fork the repo and make this change, point the pod to said repo
 
 - (void)setHighlighted:(BOOL)highlighted
 {
 _highlighted = highlighted;
 UIColor *darkBlue = [[UIColor alloc] initWithRed:51.0/255.0 green:64.0/255.0 blue:186.0/255.0 alpha:1];
 UIColor *textColor = [UIColor whiteColor];
 UIColor *backgroundColor = highlighted ? darkBlue : [UIColor clearColor];
 self.titleLabel.textColor = textColor;
 self.backgroundView.backgroundColor = backgroundColor;
 }
 
 */






// Custom Operator from https://ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/
// executes first closure on background thread then the main closure on the, you guessed it, main thread

//    func example() {
//        {self.voidFunc1()} ~> {self.voidFunc2()}
//    }

infix operator ~>
private let queue = DispatchQueue(label: "serial-worker", attributes: [])

func ~> (
    backgroundClosure: @escaping () -> (),
    mainClosure:       @escaping () -> ())
{
    queue.async {
        backgroundClosure()
        DispatchQueue.main.async(execute: mainClosure)
    }
}

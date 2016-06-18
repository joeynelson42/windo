//
//  WindoConstants.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var keyboardHeight: CGFloat = 216

let timeSelectSize: CGFloat = (screenWidth)/7
let centerPanelExpandedOffset: CGFloat = 75

let idLength = 12

let fbPermissions = ["public_profile", "email", "user_friends"]

let kFriendFBFields = "id, name, first_name, last_name, email, picture.type(large)"

let kUserLoggedIn = "userLoggedIn"
let kUserInfoReceived = "userInfoReceived"
let kUserProfile = "userProfile"

// MARK: Notifications
let ProfileImageReadyNotification = "ProfileImageReady"












// Custom Operator from https://ijoshsmith.com/2014/07/05/custom-threading-operator-in-swift/
// executes first closure on background thread then the main closure on the, you guessed it, main thread

//    func example() {
//        {self.voidFunc1()} ~> {self.voidFunc2()}
//    }

infix operator ~> {}
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)

func ~> (
    backgroundClosure: () -> (),
    mainClosure:       () -> ())
{
    dispatch_async(queue) {
        backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), mainClosure)
    }
}

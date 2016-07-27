//
//  EventManager.swift
//  Windo
//
//  Created by Joey Nelson on 7/26/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventManager {
    
    static let sharedManager = EventManager()

    func getAvailableTimes(windos:[Windo], users:[User]) -> [NSDate:[User]] {
        var userDict = [User: Windo]()
        for windo in windos {
            for user in users {
                if windo.ownerID == user.phoneNumber {
                    userDict[user] = windo
                }
            }
        }
        
        return self.computeAvailableTimes(userDict)
    }
    
    private func computeAvailableTimes(userDict: [User: Windo]) -> [NSDate:[User]]{
        var availableTimes = [NSDate:[User]]()
        for (user, windo) in userDict {
            for time in windo.times {
                if let _ = availableTimes.indexForKey(time) {
                    availableTimes[time]?.append(user)
                } else {
                    availableTimes[time] = [user]
                }
            }
        }
        return availableTimes
    }
}

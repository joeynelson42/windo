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

    func getAvailableTimes(_ windos:[Windo], users:[User]) -> [Date:[User]] {
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
    
    fileprivate func computeAvailableTimes(_ userDict: [User: Windo]) -> [Date:[User]]{
        var availableTimes = [Date:[User]]()
        for (user, windo) in userDict {
            for time in windo.times {
                if let _ = availableTimes.index(forKey: time as Date) {
                    availableTimes[time as Date]?.append(user)
                } else {
                    availableTimes[time as Date] = [user]
                }
            }
        }
        return availableTimes
    }
}

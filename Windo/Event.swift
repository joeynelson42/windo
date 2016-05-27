//
//  Event.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CoreLocation

class Event {

    var name: String!
    var location: CLLocation!
    var members: [User]!
    var eventCreator: User!
    var dateCreated: NSDate!
    var eventWindo: Windo!
    var memberWindos: [Windo]!
    var messages: [Message]!
    var possibleTimes: [NSDate]!
    
    // flags
    var isPast: Bool!
    var timesFound: Bool!
    
    
    // MARK: Public
    
    
    // MARK: Private
    
}
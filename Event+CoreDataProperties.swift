//
//  Event+CoreDataProperties.swift
//  Windo
//
//  Created by Joey on 3/25/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var name: String?
    @NSManaged var location: String?
    @NSManaged var days: String?
    @NSManaged var timesAvailable: String?
    @NSManaged var members: String?
    @NSManaged var submittedTimes: String?

}

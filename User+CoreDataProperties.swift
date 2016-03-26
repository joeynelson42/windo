//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var profilePicture: NSData?
    @NSManaged var id: String?
    @NSManaged var friends: String?

}

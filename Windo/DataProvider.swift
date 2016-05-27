//
//  DataProvider.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataProvider {
    
    static let sharedProvider = DataProvider()
    let dbRef = FIRDatabase.database().reference()
    
    func uploadNewEvent(newEvent: Event) {
        
        
    }
}
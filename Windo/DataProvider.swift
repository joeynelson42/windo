//
//  DataProvider.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Firebase

class DataProvider {
    
    static let sharedProvider = DataProvider()
    
    func uploadNewEvent(newEvent: Event) {
        var ref = FIRDatabase.database().reference()
        
        
    }
}
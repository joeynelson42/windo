//
//  UIString+.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension String {
    func getInitials() -> String{
        let firstInitial = "\(self[self.startIndex.advancedBy(0)])"
        
        guard let index = self.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(self[self.startIndex.advancedBy(self.startIndex.distanceTo(index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
}
//
//  UIString+.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension String {
    
    func isDigit() -> Bool {
        if "0"..."9" ~= self { return true }
        else { return false }
    }
    
    func getInitials() -> String{
        let firstInitial = "\(self[self.characters.index(self.startIndex, offsetBy: 0)])"
        
        guard let index = self.characters.index(of: " ") else {
            return firstInitial.uppercased()
        }
        
        let secondInitial = "\(self[self.characters.index(self.startIndex, offsetBy: self.characters.distance(from: self.startIndex, to: index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercased()
    }
    
    static func randomAlphaNumericString(_ length: Int) -> String {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.characters.index(allowedChars.startIndex, offsetBy: randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    static func randomNumericString(_ length: Int) -> String {
        
        let allowedChars = "0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.characters.index(allowedChars.startIndex, offsetBy: randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func isAlpha() -> Bool {
        for uni in self.unicodeScalars {
            if CharacterSet.decimalDigits.contains(UnicodeScalar(uni.value)!) {
                return true
            }
        }
        return false
    }
}

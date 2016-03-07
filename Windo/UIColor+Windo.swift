//
//  UIColor+Windo.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension UIColor{
    class func fromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func ghBrightRed() -> UIColor{
        let color = UIColor.fromHex(0xE73E2E, alpha: 1.0)
        return color
    }
    
    class func halfAndHalf() -> UIColor{
        let color = UIColor.fromHex(0xF1E9CA, alpha: 1.0)
        return color
    }
    
    class func halfAndHalf(alphaValue: Double) -> UIColor{
        let color = UIColor.fromHex(0xF1E9CA, alpha:  alphaValue)
        return color
    }
    
    class func crail() -> UIColor{
        let color = UIColor.fromHex(0xBF4C41, alpha: 1.0)
        return color
    }
    
    class func bud() -> UIColor{
        let color = UIColor.fromHex(0xA9B49E, alpha: 1.0)
        return color
    }
    
    class func lapisLazuli() -> UIColor{
        let color = UIColor.fromHex(0x2766A7, alpha: 1.0)
        return color
    }
    
    class func parchment() -> UIColor{
        let color = UIColor.fromHex(0xCDC6B0, alpha: 1.0)
        return color
    }
    
    class func nomad() -> UIColor{
        let color = UIColor.fromHex(0x9E9785, alpha: 1.0)
        return color
    }
    
    class func bisonHide() -> UIColor{
        let color = UIColor.fromHex(0xC3BCA7, alpha: 1.0)
        return color
    }
    
    class func hampton() -> UIColor{
        let color = UIColor.fromHex(0xE1D5B1, alpha: 1.0)
        return color
    }
    
    
    
    class func stringToHex(s: NSString)->Int{
        let numbers = [
            "a": 10, "A": 10,
            "b": 11, "B": 11,
            "c": 12, "C": 12,
            "d": 13, "D": 13,
            "e": 14, "E": 14,
            "f": 15, "F": 15,
            "0": 0
        ]
        
        var number: Int = Int()
        if(s.intValue > 0){
            number = s.integerValue
        }
        else{
            number = numbers[s as String]!
        }
        return number
    }
    
    class func ColorFromRedGreenBlue(red: NSString, green: NSString, blue: NSString)->UIColor{
        
        var first: NSString = red.substringToIndex(1)
        var second = red.substringFromIndex(1)
        var varOne = stringToHex(first)
        var varTwo = stringToHex(second)
        let redValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        first = green.substringToIndex(1)
        second = green.substringFromIndex(1)
        varOne = stringToHex(first)
        varTwo = stringToHex(second)
        let greenValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        first = blue.substringToIndex(1)
        second = blue.substringFromIndex(1)
        varOne = stringToHex(first)
        varTwo = stringToHex(second)
        let blueValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    class func languageCellColor(hex: String)->UIColor{
        var color = NSAttributedString(string: hex)
        var range = NSMakeRange(1, color.length - 1)
        color = color.attributedSubstringFromRange(range)
        range = NSMakeRange(0, 2)
        let red = color.attributedSubstringFromRange(range)
        range = NSMakeRange(2, 2)
        let green = color.attributedSubstringFromRange(range)
        range = NSMakeRange(4, 2)
        let blue = color.attributedSubstringFromRange(range)
        return ColorFromRedGreenBlue(red.string, green: green.string, blue: blue.string)
    }
}
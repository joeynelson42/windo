//
//  ColorTheme.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

enum WindoColor {
    case blue
    case purple
    case teal
}

struct ColorTheme {
    
    init(color: WindoColor) {
        self.color = color
    }
    
    var color = WindoColor.blue
    
    var lightColor: UIColor {
        switch color {
        case WindoColor.blue:
            return UIColor.lightBlue()
        case WindoColor.purple:
            return UIColor.lightPurple()
        case WindoColor.teal:
            return UIColor.lightTeal()
        }
    }
    
    var baseColor: UIColor {
        switch color {
        case WindoColor.blue:
            return UIColor.blue()
        case WindoColor.purple:
            return UIColor.purple()
        case WindoColor.teal:
            return UIColor.teal()
        }
    }
    
    var darkColor: UIColor {
        switch color {
        case WindoColor.blue:
            return UIColor.darkBlue()
        case WindoColor.purple:
            return UIColor.darkPurple()
        case WindoColor.teal:
            return UIColor.darkTeal()
        }
    }
}
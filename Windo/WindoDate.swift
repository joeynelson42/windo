//
//  WindoDate.swift
//  Windo
//
//  Created by Joey on 8/1/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

struct WindoDate {
    var year: Int!
    var month: Int!
    var day: Int!
    var hour: Int!
    var minute: Int!
    var second: Int!
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
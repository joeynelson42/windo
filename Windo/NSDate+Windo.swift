//
//  NSDate+Windo.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    
    
    func getFormattedDate(endDate: NSDate) -> String{
        var date = ""
        if(self.fullDate() == endDate.fullDate()){
            date = "\(self.fullDate())"
        }
        else if(self.year() != endDate.year()){
            date = "\(self.monthAbbrev()) \(self.day()), \(self.year()) - \(endDate.monthAbbrev()) \(endDate.day()), \(endDate.year())"
        }
        else if self.month() == endDate.month(){
            date = "\(self.monthName()) \(self.day())-\(endDate.day()), \(self.year())"
        }
        else{
            date = "\(self.monthAbbrev()) \(self.day())-\(endDate.monthAbbrev()) \(endDate.day()), \(self.year())"
        }
        return date
    }
    
    func day() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Day], fromDate: self)
        return day.day
    }
    
    func month() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.components([.Month], fromDate: self)
        return month.month
    }
    
    func year() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let year = calendar.components([.Year], fromDate: self)
        return year.year
    }
    
    func fullDate() -> String{
        return "\(self.monthName()) \(self.day()), \(self.year())"
    }
    
    func monthAbbrev() -> String{
        switch self.month(){
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func monthName() -> String{
        switch self.month(){
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    static func monthName(month: Int) -> String{
        switch month{
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func dayOfWeek() -> String{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Weekday], fromDate: self)
        switch day.weekday{
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Invalid weekday ya ding dong"
        }
    }
    
    func abbrevDayOfWeek() -> String{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Weekday], fromDate: self)
        switch day.weekday{
        case 1:
            return "SUN"
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        default:
            return "Invalid weekday ya ding dong"
        }
    }
    
    func startOfMonth() -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components([.Year, .Month], fromDate: self) else { return nil }
        comp.to12pm()
        return cal.dateFromComponents(comp)!
    }
    
    func endOfMonth() -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = NSDateComponents() else { return nil }
        comp.month = 1
        comp.day -= 1
        comp.to12pm()
        return cal.dateByAddingComponents(comp, toDate: self.startOfMonth()!, options: [])!
    }
}

internal extension NSDateComponents {
    func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}





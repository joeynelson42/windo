//
//  NSDate+Windo.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    
    static func createDateWithComponents(_ yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int, minuteNumber: Int) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var components = DateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = minuteNumber
        components.second = 0
        guard let date = calendar.date(from: components) else { return Date() }
        
        return date
    }
    
    func getWindoDate() -> WindoDate {
        return WindoDate(year: self.year(), month: self.month(), day: self.day(), hour: self.hour(), minute: self.minute(), second: 0)
    }
    
    func getFormattedDate(_ endDate: Date) -> String{
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
    
    func minute() -> Int {
        let calendar = Calendar.current
        let day = (calendar as NSCalendar).components([.minute], from: self)
        return day.minute!
    }
    
    func hour() -> Int {
        let calendar = Calendar.current
        let day = (calendar as NSCalendar).components([.hour], from: self)
        return day.hour!
    }
    
    func pmHour() -> Int {
        let calendar = Calendar.current
        let day = (calendar as NSCalendar).components([.hour], from: self)
        if day.hour! > 12 {
            return day.hour! - 12
        }
        else {
            return day.hour!
        }
    }
    
    func day() -> Int{
        let calendar = Calendar.current
        let day = (calendar as NSCalendar).components([.day], from: self)
        return day.day!
    }
    
    func month() -> Int{
        let calendar = Calendar.current
        let month = (calendar as NSCalendar).components([.month], from: self)
        return month.month!
    }
    
    func year() -> Int{
        let calendar = Calendar.current
        let year = (calendar as NSCalendar).components([.year], from: self)
        return year.year!
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
    
    func monthAbbrevCap() -> String{
        switch self.month(){
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAY"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
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
    
    static func monthName(_ month: Int) -> String{
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
        let calendar = Calendar.current
        var comp: DateComponents = (calendar as NSCalendar).components([.weekday], from: self)
        guard let day = comp.weekday else { return "" }
        switch day{
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
        let calendar = Calendar.current
        var comp: DateComponents = (calendar as NSCalendar).components([.weekday], from: self)
        guard let day = comp.weekday else { return "" }
        switch day{
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
    
    func startOfMonth() -> Date? {
        let cal: Calendar = Calendar.current
        var comp: DateComponents = (cal as NSCalendar).components([.year, .month], from: self)
        comp.to12pm()
        return cal.date(from: comp)!
    }
    
    func endOfMonth() -> Date? {
        let cal = Calendar.current
        var comp = DateComponents()
        comp.month = 1
        comp.day = comp.day! - 1
        comp.to12pm()
        return (cal as NSCalendar).date(byAdding: comp, to: self.startOfMonth()!, options: [])!
    }
    
    func firstWeekday() -> Int {
        let calendar = Calendar.current
        let firstDay = self.startOfMonth()
        let firstComponents = (calendar as NSCalendar).components([.weekday], from: firstDay!)
        return firstComponents.weekday!
    }
    
    func daysInTheMonth() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month], from: self)
        let startOfMonth = calendar.date(from: components)!
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let lastDay = (calendar as NSCalendar).date(byAdding: comps2, to: startOfMonth, options: [])!
        return lastDay.day()
    }
}

internal extension DateComponents {
    mutating func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}





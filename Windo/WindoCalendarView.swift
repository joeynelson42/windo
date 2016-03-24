//
//  WindoCalendarView.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoCalendarView: UIView {
    
    //MARK: Properties
    var month = 4
    var year = 1991
    
    var monthLabel = UILabel()
    var leftMonthButton = UIButton()
    var rightMonthButton = UIButton()
    
    //weekday labels
    var mondayLabel = UILabel()
    var tuesdayLabel = UILabel()
    var wednesdayLabel = UILabel()
    var thursdayLabel = UILabel()
    var fridayLabel = UILabel()
    var saturdayLabel = UILabel()
    var sundayLabel = UILabel()
    
    //days
    var dayBackground = UIView()
    var dragView = UIView()
    var day1 = CalendarDayView()
    var day2 = CalendarDayView()
    var day3 = CalendarDayView()
    var day4 = CalendarDayView()
    var day5 = CalendarDayView()
    var day6 = CalendarDayView()
    var day7 = CalendarDayView()
    var day8 = CalendarDayView()
    var day9 = CalendarDayView()
    var day10 = CalendarDayView()
    var day11 = CalendarDayView()
    var day12 = CalendarDayView()
    var day13 = CalendarDayView()
    var day14 = CalendarDayView()
    var day15 = CalendarDayView()
    var day16 = CalendarDayView()
    var day17 = CalendarDayView()
    var day18 = CalendarDayView()
    var day19 = CalendarDayView()
    var day20 = CalendarDayView()
    var day21 = CalendarDayView()
    var day22 = CalendarDayView()
    var day23 = CalendarDayView()
    var day24 = CalendarDayView()
    var day25 = CalendarDayView()
    var day26 = CalendarDayView()
    var day27 = CalendarDayView()
    var day28 = CalendarDayView()
    var day29 = CalendarDayView()
    var day30 = CalendarDayView()
    var day31 = CalendarDayView()
    var day32 = CalendarDayView()
    var day33 = CalendarDayView()
    var day34 = CalendarDayView()
    var day35 = CalendarDayView()
    
    var days = [CalendarDayView]()
    var daysConfigured = false
    
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        let components = calendar.components([.Month, .Year], fromDate: date)
        
        month = components.month
        year = components.year
        
        days = [day1,day2,day3,day4,day5,day6,day7,day8,day9,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,day32,day33,day34,day35]
        
        configureMonth(date, currentMonth: true)
        
        monthLabel.font = UIFont.graphikRegular(18)
        monthLabel.textColor = UIColor.darkBlue()
        monthLabel.textAlignment = .Center
        
        rightMonthButton.setImage(UIImage(named: "RightCalendarArrow"), forState: .Normal)
        rightMonthButton.addTarget(self, action: #selector(WindoCalendarView.nextMonth), forControlEvents: .TouchUpInside)
        
        leftMonthButton.setImage(UIImage(named: "LeftCalendarArrow"), forState: .Normal)
        leftMonthButton.addTarget(self, action: #selector(WindoCalendarView.previousMonth), forControlEvents: .TouchUpInside)
        
        mondayLabel.text = "M"
        mondayLabel.font = UIFont.graphikMedium(10)
        mondayLabel.textColor = UIColor.darkBlue()
        mondayLabel.textAlignment = .Center
        
        tuesdayLabel.text = "Tu"
        tuesdayLabel.font = UIFont.graphikMedium(10)
        tuesdayLabel.textColor = UIColor.darkBlue()
        tuesdayLabel.textAlignment = .Center
        
        wednesdayLabel.text = "W"
        wednesdayLabel.font = UIFont.graphikMedium(10)
        wednesdayLabel.textColor = UIColor.darkBlue()
        wednesdayLabel.textAlignment = .Center
        
        thursdayLabel.text = "T"
        thursdayLabel.font = UIFont.graphikMedium(10)
        thursdayLabel.textColor = UIColor.darkBlue()
        thursdayLabel.textAlignment = .Center
        
        fridayLabel.text = "F"
        fridayLabel.font = UIFont.graphikMedium(10)
        fridayLabel.textColor = UIColor.darkBlue()
        fridayLabel.textAlignment = .Center
        
        saturdayLabel.text = "S"
        saturdayLabel.font = UIFont.graphikMedium(10)
        saturdayLabel.textColor = UIColor.darkBlue()
        saturdayLabel.textAlignment = .Center
        
        sundayLabel.text = "S"
        sundayLabel.font = UIFont.graphikMedium(10)
        sundayLabel.textColor = UIColor.darkBlue()
        sundayLabel.textAlignment = .Center
        
        dayBackground.backgroundColor = UIColor.darkBlue()
        dragView.backgroundColor = UIColor.clearColor()
        dragView.alpha = 1.0
        
        addSubview(monthLabel)
        addSubview(rightMonthButton)
        addSubview(leftMonthButton)
        addSubview(dayBackground)

        addSubviews(mondayLabel,tuesdayLabel,wednesdayLabel,thursdayLabel,fridayLabel,saturdayLabel,sundayLabel)
        
        addSubviews(day1,day2,day3,day4,day5,day6,day7,day8,day9,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,day32,day33,day34,day35)
        
        addSubview(dragView)
        
//        configureCurrentMonth()
    }
    
    func applyConstraints(){
        monthLabel.addConstraints(
            Constraint.tt.of(self, offset: 23),
            Constraint.cxcx.of(self),
            Constraint.w.of(200),
            Constraint.h.of(18)
        )
        
        leftMonthButton.addConstraints(
            Constraint.cycy.of(monthLabel),
            Constraint.ll.of(self, offset: 18),
            Constraint.w.of(32),
            Constraint.h.of(22)
        )
        
        rightMonthButton.addConstraints(
            Constraint.cycy.of(monthLabel),
            Constraint.rr.of(self, offset: -18),
            Constraint.w.of(32),
            Constraint.h.of(22)
        )
        
        sundayLabel.addConstraints(
            Constraint.tb.of(monthLabel, offset: 22),
            Constraint.cxcx.of(self, offset: -3 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        mondayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self, offset: -2 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        tuesdayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self, offset: -(screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        wednesdayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self),
            Constraint.wh.of(18)
        )
        
        thursdayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self, offset: (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        fridayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self, offset: 2 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        saturdayLabel.addConstraints(
            Constraint.cycy.of(sundayLabel),
            Constraint.cxcx.of(self, offset: 3 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        let daySize = (screenWidth - 8)/7
        
        dayBackground.addConstraints(
            Constraint.tt.of(day1, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of((daySize * 5) + 6)
        )
        
        dragView.addConstraints(
            Constraint.tt.of(day1, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of((daySize * 5) + 6)
        )
        
        //week 1
        day1.addConstraints(
            Constraint.tb.of(monthLabel, offset: 45),
            Constraint.ll.of(self),
            Constraint.wh.of(daySize)
        )
        
        day2.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day1, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day3.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day2, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day4.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day3, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day5.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day4, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day6.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day5, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day7.addConstraints(
            Constraint.cycy.of(day1),
            Constraint.lr.of(day6, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        //week 2
        day8.addConstraints(
            Constraint.tb.of(day1, offset: 1),
            Constraint.ll.of(self),
            Constraint.wh.of(daySize)
        )
        
        day9.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day8, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day10.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day9, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day11.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day10, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day12.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day11, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day13.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day12, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day14.addConstraints(
            Constraint.cycy.of(day8),
            Constraint.lr.of(day13, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        //week 3
        day15.addConstraints(
            Constraint.tb.of(day8, offset: 1),
            Constraint.ll.of(self),
            Constraint.wh.of(daySize)
        )
        
        day16.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day15, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day17.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day16, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day18.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day17, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day19.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day18, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day20.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day19, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day21.addConstraints(
            Constraint.cycy.of(day15),
            Constraint.lr.of(day20, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        //week 4
        day22.addConstraints(
            Constraint.tb.of(day15, offset: 1),
            Constraint.ll.of(self),
            Constraint.wh.of(daySize)
        )
        
        day23.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day22, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day24.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day23, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day25.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day24, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day26.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day25, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day27.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day26, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day28.addConstraints(
            Constraint.cycy.of(day22),
            Constraint.lr.of(day27, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        //week 4
        day29.addConstraints(
            Constraint.tb.of(day22, offset: 1),
            Constraint.ll.of(self),
            Constraint.wh.of(daySize)
        )
        
        day30.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day29, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day31.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day30, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day32.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day31, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day33.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day32, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day34.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day33, offset: 1),
            Constraint.wh.of(daySize)
        )
        
        day35.addConstraints(
            Constraint.cycy.of(day29),
            Constraint.lr.of(day34, offset: 1),
            Constraint.wh.of(daySize)
        )
        
    }
    
    func configureMonth(date: NSDate, currentMonth: Bool){
        if daysConfigured { return }
        else { daysConfigured = true }
        
        let calendar = NSCalendar.currentCalendar()
        let monthName = date.monthName()
        
        let firstDay = date.startOfMonth()
        let firstComponents = calendar.components([.Weekday], fromDate: firstDay!)
        let firstWeekday = firstComponents.weekday
        
        
        let components = calendar.components([.Year, .Month], fromDate: date)
        let startOfMonth = calendar.dateFromComponents(components)!
        let comps2 = NSDateComponents()
        comps2.month = 1
        comps2.day = -1
        let lastDay = calendar.dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
        let dayCount = lastDay.day()
        
        configureMonthData(monthName, startWeekday: firstWeekday, dayCount: dayCount)
    }

    func configureMonthData(month: String, startWeekday: Int, dayCount: Int){
//        monthLabel.text = month
//        
//        var dayNumber = 0
//        switch startWeekday{
//        case 1:
//            day1 = CalendarDayView(dayNumber: 1)
//            day2 = CalendarDayView(dayNumber: 2)
//            day3 = CalendarDayView(dayNumber: 3)
//            day4 = CalendarDayView(dayNumber: 4)
//            day5 = CalendarDayView(dayNumber: 5)
//            day6 = CalendarDayView(dayNumber: 6)
//            day7 = CalendarDayView(dayNumber: 7)
//            dayNumber = 8
//        case 2:
//            day2 = CalendarDayView(dayNumber: 1)
//            day3 = CalendarDayView(dayNumber: 2)
//            day4 = CalendarDayView(dayNumber: 3)
//            day5 = CalendarDayView(dayNumber: 4)
//            day6 = CalendarDayView(dayNumber: 5)
//            day7 = CalendarDayView(dayNumber: 6)
//            dayNumber = 7
//        case 3:
//            day3 = CalendarDayView(dayNumber: 1)
//            day4 = CalendarDayView(dayNumber: 2)
// //           day5 = CalendarDayView(dayNumber: 3)
//            day6 = CalendarDayView(dayNumber: 4)
//            day7 = CalendarDayView(dayNumber: 5)
//            dayNumber = 6
//        case 4:
//            day4 = CalendarDayView(dayNumber: 1)
//            day5 = CalendarDayView(dayNumber: 2)
//            day6 = CalendarDayView(dayNumber: 3)
//            day7 = CalendarDayView(dayNumber: 4)
//            dayNumber = 5
//        case 5:
//            day5 = CalendarDayView(dayNumber: 1)
//            day6 = CalendarDayView(dayNumber: 2)
//            day7 = CalendarDayView(dayNumber: 3)
//            dayNumber = 4
//        case 6:
//            day6 = CalendarDayView(dayNumber: 1)
//            day7 = CalendarDayView(dayNumber: 2)
//            dayNumber = 3
//        case 7:
//            day7 = CalendarDayView(dayNumber: 1)
//            dayNumber = 2
//        default:
//            dayNumber = 1
//        }
//   //
//        day8 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day9 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day10 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day11 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day12 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day13 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day14 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day15 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day16 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day17 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day18 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day19 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//     //   day20 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day21 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day22 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day23 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day24 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day25 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day26 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day27 = CalendarDayView(dayNumber: dayNumber)
//        dayNumber += 1
//        day28 = CalendarDayView(dayNumber: dayNumber)
//        
//        var remainingDays = dayCount - dayNumber
//        dayNumber += 1
//        switch remainingDays {
//        case 1:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 2:
//       //     day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 3:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day31 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 4:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day31 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day32 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 5:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//         //   day31 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day32 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day33 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 6:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day31 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day32 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day33 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day34 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        case 7:
//            day29 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day30 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day31 = CalendarDayView(dayNumber: dayNumber)
//           // dayNumber += 1
//            day32 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day33 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day34 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//            day35 = CalendarDayView(dayNumber: dayNumber)
//            dayNumber += 1
//        default:
//            return
//        }
        // 161 lines were condensed into 13
        
        monthLabel.text = month
        var dayNumber = 1
        for (index,day) in days.enumerate() {
            if index < startWeekday - 1 || index > dayCount + startWeekday - 2{
                day.reset()
            }
            else{
                days[index] = CalendarDayView(dayNumber: dayNumber)
                day.day = dayNumber
                dayNumber += 1
            }
        }
    }
    
    func updateMonth(date: NSDate, currentMonth: Bool){
        if daysConfigured { return }
        else { daysConfigured = true }
        
        let calendar = NSCalendar.currentCalendar()
        let monthName = date.monthName()
        
        let firstDay = date.startOfMonth()
        let firstComponents = calendar.components([.Weekday], fromDate: firstDay!)
        let firstWeekday = firstComponents.weekday
        
        
        let components = calendar.components([.Year, .Month], fromDate: date)
        let startOfMonth = calendar.dateFromComponents(components)!
        let comps2 = NSDateComponents()
        comps2.month = 1
        comps2.day = -1
        let lastDay = calendar.dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
        let dayCount = lastDay.day()
        
        updateMonthData(monthName, startWeekday: firstWeekday, dayCount: dayCount)
    }
    
    func updateMonthData(month: String, startWeekday: Int, dayCount: Int){
        monthLabel.text = month
        
        var dayNumber = 1
        
        for (index,day) in days.enumerate() {
            if index < startWeekday - 1 || index > dayCount + startWeekday - 2{
                day.reset()
            }
            else{
                day.dateButton.setTitle("\(dayNumber)", forState: .Normal)
                day.day = dayNumber
                dayNumber += 1
            }
        }
    }
    
    func nextMonth(){
        daysConfigured = false
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
        
        components.year = year
        components.month = month
        components.day = 1
        components.hour = 14
        components.minute = 20
        components.second = 0
        let date = calendar?.dateFromComponents(components)
        let current = isCurrentMonth(date!)
        updateMonth(date!, currentMonth: current)
    }
    
    func previousMonth(){
        daysConfigured = false
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
        components.year = year
        components.month = month
        components.day = 1
        components.hour = 14
        components.minute = 20
        components.second = 0
        let date = calendar?.dateFromComponents(components)
        let current = isCurrentMonth(date!)
        updateMonth(date!, currentMonth: current)
    }
    
    func isCurrentMonth(date: NSDate) -> Bool{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: date)
        
        let currentDate = NSDate()
        let currentComponents = calendar.components([.Year, .Month], fromDate: currentDate)
        
        if components.year == currentComponents.year && components.month == currentComponents.month {
            return true
        }
        else {
            return false
        }
    }
}
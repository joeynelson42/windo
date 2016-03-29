//
//  WindoCalendarView.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol WindoCalendarDelegate {
    optional func daysSelectedDidChange(dates: [NSDate])
}

class WindoCalendarView: UIView, CalendarDayDelegate {
    
    //MARK: Properties
    var delegate: WindoCalendarDelegate!
    
    var month = 4
    var year = 1991
    
    var monthLabel = UILabel()
    var leftMonthButton = UIButton()
    var rightMonthButton = UIButton()
    var leftTapExtension = UIView()
    var rightTapExtension = UIView()
    
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
    
    // Dynamic Sizes
    let daySize = (screenWidth - 8)/7
    let spacingAroundMonth = screenHeight * 0.03448276
    
    var selectedDays = [NSDate]()
    
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
        rightMonthButton.addTarget(self, action: #selector(WindoCalendarView.goToNextMonth), forControlEvents: .TouchUpInside)
        
        leftMonthButton.setImage(UIImage(named: "LeftCalendarArrow"), forState: .Normal)
        leftMonthButton.addTarget(self, action: #selector(WindoCalendarView.goToPreviousMonth), forControlEvents: .TouchUpInside)
        
        rightTapExtension.backgroundColor = UIColor.clearColor()
        let rightTapGR = UITapGestureRecognizer(target: self, action: #selector(WindoCalendarView.goToNextMonth))
        rightTapExtension.addGestureRecognizer(rightTapGR)
        
        leftTapExtension.backgroundColor = UIColor.clearColor()
        let leftTapGR = UITapGestureRecognizer(target: self, action: #selector(WindoCalendarView.goToPreviousMonth))
        leftTapExtension.addGestureRecognizer(leftTapGR)
        
        sundayLabel.text = "S"
        sundayLabel.font = UIFont.graphikMedium(10)
        sundayLabel.textColor = UIColor.darkBlue()
        sundayLabel.textAlignment = .Center
        
        mondayLabel.text = "M"
        mondayLabel.font = UIFont.graphikMedium(10)
        mondayLabel.textColor = UIColor.darkBlue()
        mondayLabel.textAlignment = .Center
        
        tuesdayLabel.text = "T"
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
        
        dayBackground.backgroundColor = UIColor.darkBlue()
        dragView.backgroundColor = UIColor.clearColor()
        dragView.alpha = 1.0
        
        addSubview(monthLabel)
        addSubview(rightMonthButton)
        addSubview(leftMonthButton)
        addSubview(rightTapExtension)
        addSubview(leftTapExtension)
        
        addSubview(dayBackground)

        addSubviews(mondayLabel,tuesdayLabel,wednesdayLabel,thursdayLabel,fridayLabel,saturdayLabel,sundayLabel)
        
        addSubviews(day1,day2,day3,day4,day5,day6,day7,day8,day9,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,day32,day33,day34,day35)
        
        addSubview(dragView)
    }
    
    func applyConstraints(){
        
        monthLabel.addConstraints(
            Constraint.tt.of(self, offset: spacingAroundMonth),
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
        
        leftTapExtension.addConstraints(
            Constraint.cycy.of(leftMonthButton),
            Constraint.cxcx.of(leftMonthButton),
            Constraint.wh.of(50)
        )
        
        rightTapExtension.addConstraints(
            Constraint.cycy.of(rightMonthButton),
            Constraint.cxcx.of(rightMonthButton),
            Constraint.wh.of(50)
        )
        
        sundayLabel.addConstraints(
            Constraint.tb.of(monthLabel, offset: spacingAroundMonth),
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
            Constraint.tb.of(sundayLabel),
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

    func configureMonthData(monthString: String, startWeekday: Int, dayCount: Int){
        monthLabel.text = monthString
        var dayNumber = 1
        for (index,day) in days.enumerate() {
            day.delegate = self
            if index < startWeekday - 1 || index > dayCount + startWeekday - 2{
                day.updateState(false)
            }
            else{
                let date = createDateWithComponents(year, monthNumber: month, dayNumber: dayNumber)
                
                days[index] = CalendarDayView(dayNumber: dayNumber, cellDate: date)
                day.day = dayNumber
                day.date = date
                dayNumber += 1
                
                let today = NSDate()
                if day.date.fullDate() == today.fullDate() {
                    day.layer.borderColor = UIColor.whiteColor().CGColor
                    day.layer.borderWidth = 1.0
                }
                else {
                    day.layer.borderColor = UIColor.clearColor().CGColor
                    day.layer.borderWidth = 0.0
                }
            }
        }
    }
    
    func updateMonth(date: NSDate, currentMonth: Bool){
        
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
                day.updateState(false)
            }
            else{
                let date = createDateWithComponents(year, monthNumber: self.month, dayNumber: dayNumber)
                day.date = date
                
                var selected = false
                for selectedDay in selectedDays {
                    if day.date.fullDate() == selectedDay.fullDate(){
                        selected = true
                    }
                }
                
                if day.date.fullDate() == NSDate().fullDate() {
                    day.layer.borderColor = UIColor.whiteColor().CGColor
                    day.layer.borderWidth = 1.0
                }
                else {
                    day.layer.borderColor = UIColor.clearColor().CGColor
                    day.layer.borderWidth = 0.0
                }
                
                day.updateState(selected)
                day.dateButton.setTitle("\(dayNumber)", forState: .Normal)
                day.day = dayNumber
                dayNumber += 1
            }
        }
    }
    
    func goToNextMonth(){
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
        
        let date = createDateWithComponents(year, monthNumber: month, dayNumber: 1)
        let current = isCurrentMonth(date)
        updateMonth(date, currentMonth: current)
    }
    
    func goToPreviousMonth(){
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        
        let date = createDateWithComponents(year, monthNumber: month, dayNumber: 1)
        let current = isCurrentMonth(date)
        updateMonth(date, currentMonth: current)
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
    
    func updateSelectedDays(dayNumber: Int) {
        let date = createDateWithComponents(year, monthNumber: month, dayNumber: dayNumber)
        
        if selectedDays.contains(date) {
            guard let index = selectedDays.indexOf(date) else { return }
            selectedDays.removeAtIndex(index)
        }
        else {
            selectedDays.append(date)
        }
        
        selectedDays = selectedDays.sort({ $0.compare($1) == NSComparisonResult.OrderedAscending })
        
        delegate.daysSelectedDidChange!(selectedDays)
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = 16
        components.minute = 20
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
    
    func calendarHeight() -> CGFloat {
        return (spacingAroundMonth * 2) + (daySize * 5) + 41
    }
}



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
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        monthLabel.font = UIFont.graphikRegular(18)
        monthLabel.textColor = UIColor.darkBlue()
        monthLabel.text = "ERROR"
        monthLabel.textAlignment = .Center
        
        rightMonthButton.setImage(UIImage(named: "RightCalendarArrow"), forState: .Normal)
        leftMonthButton.setImage(UIImage(named: "LeftCalendarArrow"), forState: .Normal)
        
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
        
        thursdayLabel.text = "TH"
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
        
        days = [day1,day2,day3,day4,day5,day6,day7,day8,day9,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,day32,day33,day34,day35]
        
        addSubview(monthLabel)
        addSubview(rightMonthButton)
        addSubview(leftMonthButton)
        addSubview(dayBackground)

        addSubviews(mondayLabel,tuesdayLabel,wednesdayLabel,thursdayLabel,fridayLabel,saturdayLabel,sundayLabel)
        
        addSubviews(day1,day2,day3,day4,day5,day6,day7,day8,day9,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,day32,day33,day34,day35)
        
        addSubview(dragView)
        
        configureCurrentMonth()
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
            Constraint.w.of(16),
            Constraint.h.of(11)
        )
        
        rightMonthButton.addConstraints(
            Constraint.cycy.of(monthLabel),
            Constraint.rr.of(self, offset: -18),
            Constraint.w.of(16),
            Constraint.h.of(11)
        )
        
        mondayLabel.addConstraints(
            Constraint.tb.of(monthLabel, offset: 22),
            Constraint.cxcx.of(self, offset: -3 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        tuesdayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self, offset: -2 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        wednesdayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self, offset: -(screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        thursdayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self),
            Constraint.wh.of(18)
        )
        
        fridayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self, offset: (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        saturdayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self, offset: 2 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        sundayLabel.addConstraints(
            Constraint.cycy.of(mondayLabel),
            Constraint.cxcx.of(self, offset: 3 * (screenWidth/7)),
            Constraint.wh.of(18)
        )
        
        let daySize = (screenWidth - 8)/7
        
        dayBackground.addConstraints(
            Constraint.tb.of(monthLabel, offset: 36),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of((daySize * 5) + 6)
        )
        
        dragView.addConstraints(
            Constraint.tt.of(day1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of((daySize * 5) + 6)
        )
        
        //week 1
        day1.addConstraints(
            Constraint.tb.of(monthLabel, offset: 37),
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
    
    func configureCurrentMonth(){
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        let components = calendar.components([.Month, .Day], fromDate: date)
        
        monthLabel.text = date.monthName()
    }
    
    func nextMonth(){
        
    }
    
    func previousMonth(){
        
    }
}
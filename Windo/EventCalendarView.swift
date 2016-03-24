//
//  EventCalendarView.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventCalendarView: UIView {
    
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
    
    //weeks
    var week1 = CalendarWeekView()
    var week2 = CalendarWeekView()
    var week3 = CalendarWeekView()
    var week4 = CalendarWeekView()
    var week5 = CalendarWeekView()
    
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        monthLabel.font = UIFont.graphikRegular(18)
        monthLabel.textColor = UIColor.darkBlue()
        monthLabel.text = "March"
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
        
        addSubview(monthLabel)
        addSubview(rightMonthButton)
        addSubview(leftMonthButton)
        
        addSubview(mondayLabel)
        addSubview(tuesdayLabel)
        addSubview(wednesdayLabel)
        addSubview(thursdayLabel)
        addSubview(fridayLabel)
        addSubview(saturdayLabel)
        addSubview(sundayLabel)
        
        addSubview(week1)
        addSubview(week2)
        addSubview(week3)
        addSubview(week4)
        addSubview(week5)
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
        
        week1.addConstraints(
            Constraint.tb.of(monthLabel, offset: 37),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(55)
        )
        
        let weekVerticalOffset: CGFloat = -2
        
        week2.addConstraints(
            Constraint.tb.of(week1, offset: weekVerticalOffset),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(55)
        )
        
        week3.addConstraints(
            Constraint.tb.of(week2, offset: weekVerticalOffset),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(55)
        )
        
        week4.addConstraints(
            Constraint.tb.of(week3, offset: weekVerticalOffset),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(55)
        )
        
        week5.addConstraints(
            Constraint.tb.of(week4, offset: weekVerticalOffset),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(55)
        )
    }
}

//
//  CalendarWeekView.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class CalendarWeekView: UIView {
    
    //MARK: Properties
    var stackView = UIStackView()
    var mondayView = UIView()
    var tuesdayView = UIView()
    var wednesdayView = UIView()
    var thursdayView = UIView()
    var fridayView = UIView()
    var saturdayView = UIView()
    var sundayView = UIView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.clearColor()
        
        let dayColor = UIColor.darkBlue()
        
        mondayView.backgroundColor = dayColor
        tuesdayView.backgroundColor = dayColor
        wednesdayView.backgroundColor = dayColor
        thursdayView.backgroundColor = dayColor
        fridayView.backgroundColor = dayColor
        saturdayView.backgroundColor = dayColor
        sundayView.backgroundColor = dayColor
        
        let dayArray = [mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, sundayView]
        stackView = UIStackView(arrangedSubviews: dayArray)
        stackView.axis = .Horizontal
        stackView.distribution = .Fill
        stackView.alignment = .Center
        stackView.spacing = 1
        
        addSubview(stackView)
    }
    
    func applyConstraints(){
        stackView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth - 2),
            Constraint.h.of(55)
        )
        
        let daySize: CGFloat = (screenWidth - 8)/7
        
        mondayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        tuesdayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        wednesdayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        thursdayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        fridayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        saturdayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
        sundayView.addConstraints(
            Constraint.wh.of(daySize)
        )
        
    }
}
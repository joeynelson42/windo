//
//  CalendarDayView.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol CalendarDayDelegate {
    @objc optional func updateSelectedDays(_ dayNumber: Int)
}

enum DayState{
    case past
    case unselected
    case selected
    case empty
}

class CalendarDayView: FSCalendarCell {
    
    //MARK: Properties
//    var delegate: CalendarDayDelegate!
    var state = DayState.empty
    
    var selectedBackground = UIView()
    var dateButton = UIButton()
    
    var day = 0
    var date: Date!
    
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(dayNumber: Int, cellDate: Date){
        self.init(frame: CGRect.zero)
        day = dayNumber
        date = cellDate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.blue()
        
//        dateButton.setTitle("\(day)", for: UIControlState())
        dateButton.setTitleColor(UIColor.white, for: UIControlState())
        dateButton.alpha = 0.75
        dateButton.titleLabel?.font = UIFont.graphikRegular(18)
        dateButton.addTarget(self, action: #selector(CalendarDayView.tapped), for: .touchUpInside)
        
        updateState()
        
        addSubview(selectedBackground)
        addSubview(dateButton)
    }
    
    func applyConstraints(){
        let daySize: CGFloat = (screenWidth - 8)/7
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
        
        dateButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
    }
    
    func tapped(){
//        if state == .empty || state == .past{
//            return
//        }
        
        if selectedBackground.alpha == 0 {
            state = .selected
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { void in
                    self.dateButton.alpha = 1.0
                    self.selectedBackground.alpha = 1.0
                    self.selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
        }
        else {
            state = .unselected
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { void in
                self.dateButton.alpha = 0.75
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion: nil)
        }
        
//        delegate.updateSelectedDays!(day)
    }
    
    func updateState(){
        switch state {
        case .past:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.gray
            selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            dateButton.alpha = 0.25
        case .selected:
            selectedBackground.alpha = 1.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            dateButton.alpha = 1.0
        case .unselected:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            dateButton.alpha = 0.75
        case .empty:
            dateButton.setTitle("", for: UIControlState())
            selectedBackground.alpha = 0.0
            selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            dateButton.alpha = 0.0
            layer.borderWidth = 0
            return
        }
        
        guard let _ = date else { return }
        let today = Date()
        if date.fullDate() == today.fullDate() {
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 1.0
        }
        else {
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0.0
        }
    }
}

//
//  ExpandingTimeCell.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol ExpandingTimeCellDelegate {
    func stateForTime(time: NSDate) -> TimeCellState
    func timeCellStateChanged(newState: TimeCellState, date: NSDate)
}

enum ExpandingTimeCellState {
    case expanded
    case closed
}

class ExpandingTimeCell: UIView, TimeCellDelegate {
    
    //MARK: Properties
    
    var state = ExpandingTimeCellState.closed
    
    var colorTheme = ColorTheme(color: .blue)
    var baseTime = NSDate()
    var delegate: ExpandingTimeCellDelegate!
    
    var hourCell: TimeCell!
    var quarterCell: TimeCell!
    var halfCell: TimeCell!
    var threeQuartersCell: TimeCell!
    
    //MARK: Inits
    
    private convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(state: ExpandingTimeCellState, colorTheme: ColorTheme, time: NSDate, delegate: ExpandingTimeCellDelegate){
        self.init(frame: CGRectZero)
        self.state = state
        self.colorTheme = colorTheme
        self.baseTime = time
        self.delegate = delegate
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func toggle() {
        if state == .closed {
            state = .expanded
        } else {
            state = .closed
        }
        
        applyConstraints()
        
        quarterCell.unhide()
        halfCell.unhide()
        threeQuartersCell.unhide()
        
//        UIView.animateWithDuration(0.5) {
//            self.layoutIfNeeded()
//        }
    }
    
    // MARK: TimeCellDelegate Methods
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {
        delegate.timeCellStateChanged(newState, date: date)
    }
    
    // MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        backgroundColor = colorTheme.darkColor
        clipsToBounds = false
        let times = createTimes()
        
        if let _ = hourCell {
            return
        }
//        hourCell = TimeCell(state: delegate.stateForTime(times[0]), colorTheme: colorTheme, time: times[0], delegate: self)
//        quarterCell = TimeCell(state: delegate.stateForTime(times[1]), colorTheme: colorTheme, time: times[1], delegate: self)
//        halfCell = TimeCell(state: delegate.stateForTime(times[2]), colorTheme: colorTheme, time: times[2], delegate: self)
//        threeQuartersCell = TimeCell(state: delegate.stateForTime(times[3]), colorTheme: colorTheme, time: times[3], delegate: self)

        hourCell = TimeCell(state: delegate.stateForTime(times[0]), colorTheme: colorTheme, time: times[0], delegate: self)
        quarterCell = TimeCell(state: .hidden, colorTheme: colorTheme, time: times[1], delegate: self)
        halfCell = TimeCell(state: .hidden, colorTheme: colorTheme, time: times[2], delegate: self)
        threeQuartersCell = TimeCell(state: .hidden, colorTheme: colorTheme, time: times[3], delegate: self)
        
        addSubview(threeQuartersCell)
        addSubview(halfCell)
        addSubview(quarterCell)
        addSubview(hourCell)
    }
    
    func applyConstraints() {
        if state == .closed {
            hourCell.addConstraints(
                Constraint.tt.of(self),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            quarterCell.addConstraints(
                Constraint.tt.of(self),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            halfCell.addConstraints(
                Constraint.tt.of(self),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            threeQuartersCell.addConstraints(
                Constraint.tt.of(self),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
        } else {
            hourCell.addConstraints(
                Constraint.tt.of(self),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            quarterCell.addConstraints(
                Constraint.tb.of(hourCell, offset: 1),
                Constraint.wh.of(timeSelectSize),
                Constraint.cxcx.of(self)
            )
            
            halfCell.addConstraints(
                Constraint.tb.of(quarterCell, offset: 1),
                Constraint.wh.of(timeSelectSize),
                Constraint.cxcx.of(self)
            )
            
            threeQuartersCell.addConstraints(
                Constraint.tb.of(halfCell, offset: 1),
                Constraint.wh.of(timeSelectSize),
                Constraint.cxcx.of(self)
            )
        }
    }
    
    // MARK: Utilities
    
    func createTimes() -> [NSDate]{
        var times = [NSDate]()
        
        times.append(baseTime)
        times.append(NSDate.createDateWithComponents(baseTime.year(), monthNumber: baseTime.month(), dayNumber: baseTime.day(), hourNumber: baseTime.hour(), minuteNumber: 15))
        times.append(NSDate.createDateWithComponents(baseTime.year(), monthNumber: baseTime.month(), dayNumber: baseTime.day(), hourNumber: baseTime.hour(), minuteNumber: 30))
        times.append(NSDate.createDateWithComponents(baseTime.year(), monthNumber: baseTime.month(), dayNumber: baseTime.day(), hourNumber: baseTime.hour(), minuteNumber: 45))
        
        return times
    }
}
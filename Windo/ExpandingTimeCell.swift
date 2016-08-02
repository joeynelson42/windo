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
    var baseTime = NSDate() {
        didSet {
            self.updateTimes()
        }
    }
    var delegate: ExpandingTimeCellDelegate!
    
    var hourCell = TimeCell()
    var quarterCell = TimeCell()
    var halfCell = TimeCell()
    var threeQuartersCell = TimeCell()
    
    //MARK: Inits
    
    private convenience init() {
        self.init(frame: CGRectZero)
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
        
//        quarterCell.unhide()
//        halfCell.unhide()
//        threeQuartersCell.unhide()
        
        UIView.animateWithDuration(0.25) {
            self.layoutIfNeeded()
        }
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

        hourCell.state = delegate.stateForTime(times[0])
        hourCell.colorTheme = colorTheme
        hourCell.time = times[0]
        hourCell.delegate = self
        
        quarterCell.state = delegate.stateForTime(times[1])
        quarterCell.colorTheme = colorTheme
        quarterCell.time = times[1]
        quarterCell.delegate = self
        
        halfCell.state = delegate.stateForTime(times[2])
        halfCell.colorTheme = colorTheme
        halfCell.time = times[2]
        halfCell.delegate = self
        
        threeQuartersCell.state = delegate.stateForTime(times[3])
        threeQuartersCell.colorTheme = colorTheme
        threeQuartersCell.time = times[3]
        threeQuartersCell.delegate = self
        
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
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            halfCell.addConstraints(
                Constraint.tb.of(quarterCell, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
            
            threeQuartersCell.addConstraints(
                Constraint.tb.of(halfCell, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.wh.of(timeSelectSize)
            )
        }
    }
    
    func updateTimes() {
        let times = createTimes()
        
        hourCell.time = times[0]
        quarterCell.time = times[1]
        halfCell.time = times[2]
        threeQuartersCell.time = times[3]
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
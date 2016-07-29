//
//  ExpandingTimeRow.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol ExpandingTimeRowDelegate {
    func stateForTime(time: NSDate) -> TimeCellState
    func timeCellStateChanged(newState: TimeCellState, date: NSDate)
}

enum ExpandingTimeRowState {
    case expanded
    case closed
}

class ExpandingTimeRow: UIView, ExpandingTimeCellDelegate {
    
    //MARK: Properties
    
    var state = ExpandingTimeRowState.closed
    
    var colorTheme = ColorTheme(color: .blue)
    var baseTime = NSDate()
    var delegate: ExpandingTimeRowDelegate!
    
    var hour1 = ExpandingTimeCell()
    var hour2 = ExpandingTimeCell()
    var hour3 = ExpandingTimeCell()
    var hour4 = ExpandingTimeCell()
    var hour5 = ExpandingTimeCell()
    var hour6 = ExpandingTimeCell()
    
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
        
        toggleCellExpand()
    }
    
    func toggleCellExpand() {
        hour1.toggle()
        hour2.toggle()
        hour3.toggle()
        hour4.toggle()
        hour5.toggle()
        hour6.toggle()
    }
    
    
    // MARK: ExpandingTimeCellDelegate Methods
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {
        delegate.timeCellStateChanged(newState, date: date)
    }
    
    func stateForTime(time: NSDate) -> TimeCellState {
        return delegate.stateForTime(time)
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
        var timeCellState = ExpandingTimeCellState.closed
        if self.state == .expanded {
            timeCellState = .expanded
        }
        
        hour1.state = timeCellState
        hour1.colorTheme = colorTheme
        hour1.baseTime = times[0]
        hour1.delegate = self
        
        hour2.state = timeCellState
        hour2.colorTheme = colorTheme
        hour2.baseTime = times[1]
        hour2.delegate = self
        
        hour3.state = timeCellState
        hour3.colorTheme = colorTheme
        hour3.baseTime = times[2]
        hour3.delegate = self
        
        hour4.state = timeCellState
        hour4.colorTheme = colorTheme
        hour4.baseTime = times[3]
        hour4.delegate = self
        
        hour5.state = timeCellState
        hour5.colorTheme = colorTheme
        hour5.baseTime = times[4]
        hour5.delegate = self
        
        hour6.state = timeCellState
        hour6.colorTheme = colorTheme
        hour6.baseTime = times[5]
        hour6.delegate = self
        
        addSubviews(hour1, hour2, hour3, hour4, hour5, hour6)
    }
    
    func applyConstraints() {
        hour1.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.ll.of(self, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        hour2.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.lr.of(hour1, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        hour3.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.lr.of(hour2, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        hour4.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.lr.of(hour3, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        hour5.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.lr.of(hour4, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        hour6.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.lr.of(hour5, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
    }
    
    // MARK: Utilities
    
    func createTimes() -> [NSDate]{
        var times = [NSDate]()
        
        times.append(baseTime)
        for n in 1...5 {
            times.append(NSDate.createDateWithComponents(baseTime.year(), monthNumber: baseTime.month(), dayNumber: baseTime.day(), hourNumber: baseTime.hour() + n, minuteNumber: 0))
        }
        
        return times
    }
}
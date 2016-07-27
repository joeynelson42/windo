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
    
    var expandButton = UIButton()
    var hour1: ExpandingTimeCell!
    var hour2: ExpandingTimeCell!
    var hour3: ExpandingTimeCell!
    var hour4: ExpandingTimeCell!
    var hour5: ExpandingTimeCell!
    var hour6: ExpandingTimeCell!
    
    //MARK: Inits
    
    private convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(state: ExpandingTimeRowState, colorTheme: ColorTheme, baseTime: NSDate, delegate: ExpandingTimeRowDelegate){
        self.init(frame: CGRectZero)
        self.state = state
        self.colorTheme = colorTheme
        self.baseTime = baseTime
        self.delegate = delegate
        
        self.expandButton.addTarget(.TouchUpInside) { 
            self.toggleCellExpand()
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
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
        expandButton.backgroundColor = UIColor.whiteColor()
        clipsToBounds = false
        let times = createTimes()
        var timeCellState = ExpandingTimeCellState.closed
        if self.state == .expanded {
            timeCellState = .expanded
        }
        
        if let _ = hour1 {
            return
        }
        
        hour1 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[0], delegate: self)
        hour2 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[1], delegate: self)
        hour3 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[2], delegate: self)
        hour4 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[3], delegate: self)
        hour5 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[4], delegate: self)
        hour6 = ExpandingTimeCell(state: timeCellState, colorTheme: colorTheme, time: times[5], delegate: self)
        
        addSubviews(hour1, hour2, hour3, hour4, hour5, hour6, expandButton)
    }
    
    func applyConstraints() {
        hour1.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        hour2.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hour1, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        hour3.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hour2, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        hour4.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hour3, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        hour5.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hour4, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        hour6.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hour5, offset: 1),
            Constraint.wh.of(timeSelectSize + 1)
        )
        
        expandButton.addConstraints(
            Constraint.lr.of(hour6, offset: 10),
            Constraint.cycy.of(self),
            Constraint.wh.of(40)
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
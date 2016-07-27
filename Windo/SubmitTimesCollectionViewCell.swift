//
//  SubmitTimesCollectionViewCell.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol SubmitTimesCollectionViewCellDelegate {
    func stateForTime(time: NSDate) -> TimeCellState
    func timeCellStateChanged(newState: TimeCellState, date: NSDate)
}

class SubmitTimesCollectionViewCell: UICollectionViewCell, ExpandingTimeRowDelegate {
    
    //MARK: Properties
    var delegate: SubmitTimesCollectionViewCellDelegate!
    var date = NSDate()
    var colorTheme = ColorTheme(color: .blue)
    
    var row1: ExpandingTimeRow!
    var row2: ExpandingTimeRow!
    var row3: ExpandingTimeRow!
    var row4: ExpandingTimeRow!
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: ExpandingTimeRowDelegate
    func stateForTime(time: NSDate) -> TimeCellState {
        return TimeCellState.unselected
    }
    
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
        let times = createTimes()
        
        row1 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[0], delegate: self)
        
        row2 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[1], delegate: self)
        
        row3 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[2], delegate: self)
        
        row4 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[3], delegate: self)
        
        addSubviews(row1, row2, row3, row4)
    }
    
    func applyConstraints() {
        row1.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.llrr.of(self, offset: 1),
            Constraint.h.of(timeSelectSize)
        )
        
        row2.addConstraints(
            Constraint.tb.of(row1, offset: 1),
            Constraint.llrr.of(self, offset: 1),
            Constraint.h.of(timeSelectSize)
        )
        
        row3.addConstraints(
            Constraint.tb.of(row2, offset: 1),
            Constraint.llrr.of(self, offset: 1),
            Constraint.h.of(timeSelectSize)
        )
        
        row4.addConstraints(
            Constraint.tb.of(row3, offset: 1),
            Constraint.llrr.of(self, offset: 1),
            Constraint.h.of(timeSelectSize)
        )
    }
    
    // MARK: Utilities
    
    func createTimes() -> [NSDate]{
        var times = [NSDate]()
        
        for n in 0...3 {
            times.append(NSDate.createDateWithComponents(date.year(), monthNumber: date.month(), dayNumber: date.day(), hourNumber: n * 6, minuteNumber: 0))
        }
        
        return times
    }
}
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

class SubmitTimesCollectionViewCell: UIView, ExpandingTimeRowDelegate {
    
    //MARK: Properties
    var delegate: SubmitTimesCollectionViewCellDelegate!
    var date = NSDate()
    var colorTheme = ColorTheme(color: .blue)
    
    var expandRow1Button = UIButton()
//    var expandRow2Button = UIButton()
    var expandRow3Button = UIButton()
    var expandRow4Button = UIButton()
    
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
        
        if let _ = row1 {
            return
        }
        
        row1 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[0], delegate: self)
        
        row2 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[1], delegate: self)
        
        row3 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[2], delegate: self)
        
        row4 = ExpandingTimeRow(state: ExpandingTimeRowState.closed, colorTheme: colorTheme, baseTime: times[3], delegate: self)
        
        let expandRowImage = UIImage(named: "expandArrow")
        let expandRowPassiveAlpha:CGFloat = 1.0
        
        expandRow1Button.setImage(expandRowImage, forState: .Normal)
        expandRow1Button.alpha = expandRowPassiveAlpha
        expandRow1Button.addTarget(.TouchUpInside) {
            self.applyConstraints()
            self.addExpandedRow1Constraints()
            self.row1.toggleCellExpand()
        }
        
//        expandRow2Button.setImage(expandRowImage, forState: .Normal)
//        expandRow2Button.alpha = expandRowPassiveAlpha
//        expandRow2Button.backgroundColor = .purple()
//        expandRow2Button.addTarget(.TouchUpInside) {
//            self.applyConstraints()
//            self.addExpandedRow2Constraints()
//            self.row2.toggleCellExpand()
//            
//            UIView.animateWithDuration(0.25, animations: { 
//                self.layoutIfNeeded()
//            })
//        }
        
        expandRow3Button.setImage(expandRowImage, forState: .Normal)
        expandRow3Button.alpha = expandRowPassiveAlpha
        expandRow3Button.addTarget(.TouchUpInside) {
            self.applyConstraints()
            self.addExpandedRow3Constraints()
            self.row3.toggleCellExpand()
        }
        
        expandRow4Button.setImage(expandRowImage, forState: .Normal)
        expandRow4Button.alpha = expandRowPassiveAlpha
        expandRow4Button.addTarget(.TouchUpInside) {
            self.applyConstraints()
            self.addExpandedRow4Constraints()
            self.row4.toggleCellExpand()
        }
        
        addSubviews(row1, row2, row3, row4)
        addSubview(expandRow1Button)
//        addSubview(expandRow2Button)
        addSubview(expandRow3Button)
        addSubview(expandRow4Button)
    }
    
    func applyConstraints() {
        row1.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.cxcx.of(self),
            Constraint.h.of(timeSelectSize + 2),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
        expandRow1Button.addConstraints(
            Constraint.lr.of(row1, offset: 5),
            Constraint.cyt.of(row1, offset: timeSelectSize/2),
            Constraint.wh.of(40)
        )
        
        row2.addConstraints(
            Constraint.tb.of(row1, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.h.of(timeSelectSize + 2),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
//        expandRow2Button.addConstraints(
//            Constraint.lr.of(row2, offset: 5),
//            Constraint.cyt.of(row2, offset: timeSelectSize/2),
//            Constraint.wh.of(40)
//        )
        
        row3.addConstraints(
            Constraint.tb.of(row2, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.h.of(timeSelectSize + 2),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
        expandRow3Button.addConstraints(
            Constraint.lr.of(row3, offset: 5),
            Constraint.cyt.of(row3, offset: timeSelectSize/2),
            Constraint.wh.of(40)
        )
        
        row4.addConstraints(
            Constraint.tb.of(row3, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.h.of(timeSelectSize + 2),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
        expandRow4Button.addConstraints(
            Constraint.lr.of(row4, offset: 5),
            Constraint.cyt.of(row4, offset: timeSelectSize/2),
            Constraint.wh.of(40)
        )
    }
    
    func addExpandedRow1Constraints() {
        row1.addConstraints(
            Constraint.tt.of(self, offset: 1),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.h.of((timeSelectSize * 4) + 5),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
    }
    
    func addExpandedRow2Constraints() {
        row2.addConstraints(
            Constraint.tb.of(row1, offset: 1),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.h.of((timeSelectSize * 4) + 5),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
    }
    
    func addExpandedRow3Constraints() {
        row3.addConstraints(
            Constraint.tb.of(row2, offset: 1),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.h.of((timeSelectSize * 4) + 5),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
    }
    
    func addExpandedRow4Constraints() {
        row4.addConstraints(
            Constraint.tb.of(row3, offset: 1),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.h.of((timeSelectSize * 4) + 5),
            Constraint.w.of((timeSelectSize * 6) + 7)
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
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
    var expandRow2Button = UIButton()
    var expandRow3Button = UIButton()
    var expandRow4Button = UIButton()
    
    var row1 = ExpandingTimeRow()
    var row2 = ExpandingTimeRow()
    var row3 = ExpandingTimeRow()
    var row4 = ExpandingTimeRow()
    
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
//        delegate.timeCellStateChanged(newState, date: date)
    }
    
    // MARK: View Configuration
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        let times = createTimes()
        
        clipsToBounds = false
        
        row1.state = .closed
        row1.colorTheme = colorTheme
        row1.baseTime = times[0]
        row1.delegate = self
        
        row2.state = .closed
        row2.colorTheme = colorTheme
        row2.baseTime = times[1]
        row2.delegate = self
        
        row3.state = .closed
        row3.colorTheme = colorTheme
        row3.baseTime = times[2]
        row3.delegate = self
        
        row4.state = .closed
        row4.colorTheme = colorTheme
        row4.baseTime = times[3]
        row4.delegate = self
        
        let expandRowImage = UIImage(named: "expandArrow")
        let expandRowPassiveAlpha:CGFloat = 1.0
        
        expandRow1Button.setImage(expandRowImage, forState: .Normal)
        expandRow1Button.alpha = expandRowPassiveAlpha
        expandRow1Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow1), forControlEvents: .TouchUpInside)
        
        expandRow2Button.setImage(expandRowImage, forState: .Normal)
        expandRow2Button.alpha = expandRowPassiveAlpha
        expandRow2Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow2), forControlEvents: .TouchUpInside)
        
        expandRow3Button.setImage(expandRowImage, forState: .Normal)
        expandRow3Button.alpha = expandRowPassiveAlpha
        expandRow3Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow3), forControlEvents: .TouchUpInside)
        
        expandRow4Button.setImage(expandRowImage, forState: .Normal)
        expandRow4Button.alpha = expandRowPassiveAlpha
        expandRow4Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow4), forControlEvents: .TouchUpInside)
        
        addSubviews(row1, row2, row3, row4)
        addSubview(expandRow1Button)
        addSubview(expandRow2Button)
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
        
        expandRow2Button.addConstraints(
            Constraint.lr.of(row2, offset: 5),
            Constraint.cyt.of(row2, offset: timeSelectSize/2),
            Constraint.wh.of(40)
        )
        
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
    
    func toggleRow1() {
        self.applyConstraints()
        
        self.row1.toggle()
        
        if row1.state == .expanded {
            row1.addConstraints(
                Constraint.tt.of(self, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.h.of((timeSelectSize * 4) + 5),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        } else {
            row1.addConstraints(
                Constraint.tt.of(self, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.h.of(timeSelectSize + 2),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        }
        
        self.row1.state = .expanded
        UIView.animateWithDuration(0.25, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func toggleRow2() {
        self.applyConstraints()
        
        self.row2.toggle()
        
        if row2.state == .expanded {
            row2.addConstraints(
                Constraint.tb.of(row1, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.h.of((timeSelectSize * 4) + 5),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        } else {
            row2.addConstraints(
                Constraint.tb.of(row1, offset: -1),
                Constraint.cxcx.of(self),
                Constraint.h.of(timeSelectSize + 2),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        }
        
        UIView.animateWithDuration(0.25, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func toggleRow3() {
        self.applyConstraints()
        
        self.row3.toggle()
        
        if row3.state == .expanded {
            row3.addConstraints(
                Constraint.tb.of(row2, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.h.of((timeSelectSize * 4) + 5),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        } else {
            row3.addConstraints(
                Constraint.tb.of(row2, offset: -1),
                Constraint.cxcx.of(self),
                Constraint.h.of(timeSelectSize + 2),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        }
        
        self.row3.state = .expanded
        UIView.animateWithDuration(0.25, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func toggleRow4() {
        self.applyConstraints()
        
        self.row4.toggle()
        
        if row4.state == .expanded {
            row4.addConstraints(
                Constraint.tb.of(row3, offset: 1),
                Constraint.cxcx.of(self),
                Constraint.h.of((timeSelectSize * 4) + 5),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        } else {
            row4.addConstraints(
                Constraint.tb.of(row3, offset: -1),
                Constraint.cxcx.of(self),
                Constraint.h.of(timeSelectSize + 2),
                Constraint.w.of((timeSelectSize * 6) + 7)
            )
        }
    
        self.row4.state = .expanded
        UIView.animateWithDuration(0.25, animations: {
            self.layoutIfNeeded()
        })
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
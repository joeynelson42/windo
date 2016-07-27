//
//  SubmitTimesView.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SubmitTimesView: UIView, ExpandingTimeRowDelegate{
    
    //MARK: Properties
    var row: ExpandingTimeRow!
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
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
        backgroundColor = UIColor.greenColor()
        
        
        if let _ = row {
            return
        }
        
        let date = NSDate.createDateWithComponents(NSDate().year(), monthNumber: NSDate().month(), dayNumber: NSDate().day(), hourNumber: 6, minuteNumber: 0)
        
        row = ExpandingTimeRow(state: .closed, colorTheme: ColorTheme(color: .blue), baseTime: date, delegate: self)
        addSubview(row)
    }
    
    func applyConstraints(){
        row.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.h.of(timeSelectSize + 2),
            Constraint.w.of((timeSelectSize + 7) * 6)
        )
    }
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {
//        print(date)
    }
    
    func stateForTime(time: NSDate) -> TimeCellState {
        return .unselected
    }
}
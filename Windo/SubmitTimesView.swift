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
    var rows = SubmitTimesCollectionViewCell()

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
        backgroundColor = UIColor.blue()
        
        addSubview(rows)
    }
    
    func applyConstraints(){
        rows.addConstraints(
            Constraint.tt.of(self, offset: 100),
            Constraint.ll.of(self, offset: 0),
            Constraint.h.of((timeSelectSize + 2) * 4),
            Constraint.w.of(screenWidth)
        )
    }
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {

    }
    
    func stateForTime(time: NSDate) -> TimeCellState {
        return .unselected
    }
}
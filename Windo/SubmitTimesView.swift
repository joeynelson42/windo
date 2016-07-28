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
    var expandRow2Button = UIButton()
    
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
        
//        expandRow2Button.setImage(expandRowImage, forState: .Normal)
//        expandRow2Button.alpha = expandRowPassiveAlpha
        expandRow2Button.backgroundColor = .purple()
        expandRow2Button.addTarget(.TouchUpInside) {
            self.rows.applyConstraints()
            self.rows.addExpandedRow2Constraints()
            self.rows.row2.toggleCellExpand()
            
            UIView.animateWithDuration(0.25, animations: {
                self.layoutIfNeeded()
            })
        }
        
        addSubview(rows)
        addSubview(expandRow2Button)
    }
    
    func applyConstraints(){
        rows.addConstraints(
            Constraint.tt.of(self, offset: 100),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.h.of((timeSelectSize + 2) * 4),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
        expandRow2Button.addConstraints(
            Constraint.lr.of(self.rows.row2, offset: 5),
            Constraint.cyt.of(self.rows.row2, offset: timeSelectSize/2),
            Constraint.wh.of(40)
        )
    }
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {

    }
    
    func stateForTime(time: NSDate) -> TimeCellState {
        return .unselected
    }
}
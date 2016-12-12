//
//  SubmitTimesView.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SubmitTimesView: UIView{
    
    //MARK: Properties
    var rows = SubmitTimesCollectionViewCell()

    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
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
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
    }
    
    func timeCellStateChanged(_ newState: TimeCellState, date: Date) {

    }
    
    func stateForTime(_ time: Date) -> TimeCellState {
        return .unselected
    }
}

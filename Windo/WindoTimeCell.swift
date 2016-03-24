//
//  WindoTimeCell.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoTimeCell: UIView {
    
    //MARK: Properties
    var timeButton = UIButton()
    var time = 0
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(cellTime: Int){
        self.init(frame: CGRectZero)
        time = cellTime
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
        timeButton.setTitle("\(time)", forState: .Normal)
        timeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        timeButton.titleLabel!.font = UIFont.graphikRegular(20)
        
        addSubview(timeButton)
    }
    
    func applyConstraints(){
        timeButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(60)
        )
        
    }
}
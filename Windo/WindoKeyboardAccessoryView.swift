//
//  WindoKeyboardAccessoryView.swift
//  Windo
//
//  Created by Joey on 3/28/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoKeyboardAccessoryView: UIView {
    
    //MARK: Properties
    var doneButton = UIButton()
    
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
        backgroundColor = UIColor.whiteColor()
        
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.titleLabel?.font = UIFont.graphikMedium(18)
        doneButton.setTitleColor(UIColor.blue(), forState: .Normal)
        
        addSubview(doneButton)
    }
    
    func applyConstraints(){
        doneButton.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self, offset: -15),
            Constraint.w.of(60),
            Constraint.h.of(30)
        )
    }
}
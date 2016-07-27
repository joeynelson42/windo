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
    var leftArrowButton = UIButton()
    var rightArrowButton = UIButton()
    var state: ColorTheme!
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(frame: CGRect, state: ColorTheme) {
        self.init(frame: frame)
        self.state = state
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
        
        switch state.color {
        case .blue:
            doneButton.setTitleColor(UIColor.blue(), forState: .Normal)
            leftArrowButton.setImage(UIImage(named: "blueLeftArrow"), forState: .Normal)
            rightArrowButton.setImage(UIImage(named: "blueRightArrow"), forState: .Normal)
        case .teal:
            doneButton.setTitleColor(UIColor.teal(), forState: .Normal)
            leftArrowButton.setImage(UIImage(named: "tealLeftArrow"), forState: .Normal)
            rightArrowButton.setImage(UIImage(named: "tealRightArrow"), forState: .Normal)
        case .purple:
            doneButton.setTitleColor(UIColor.purple(), forState: .Normal)
            leftArrowButton.setImage(UIImage(named: "purpleLeftArrow"), forState: .Normal)
            rightArrowButton.setImage(UIImage(named: "purpleRightArrow"), forState: .Normal)
        }
        
        
        
        addSubview(leftArrowButton)
        addSubview(rightArrowButton)
        addSubview(doneButton)
    }
    
    func applyConstraints(){
        
        leftArrowButton.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self, offset: 5),
            Constraint.wh.of(40)
        )
        
        rightArrowButton.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(leftArrowButton, offset: 0),
            Constraint.wh.of(40)
        )
        
        doneButton.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self, offset: -15),
            Constraint.w.of(60),
            Constraint.h.of(30)
        )
    }
}
//
//  PhoneNumberInputView.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class PhoneNumberInputView: UIView {
    
    //MARK: Properties
    let numberPad = WindoNumberPad()
    
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
        backgroundColor = UIColor.lightTeal()
        
//        phoneNumberTextField.userInteractionEnabled = false
//        phoneNumberTextField.placeholderText = " "
//        phoneNumberTextField.textColor = UIColor.whiteColor()
//        phoneNumberTextField.font = UIFont.graphikRegular(30)
        
        addSubview(numberPad)
//        addSubview(phoneNumberTextField)
    }
    
    func applyConstraints(){
        numberPad.addConstraints(
            Constraint.llrr.of(self, offset: 10),
            Constraint.bb.of(self, offset: -20)
        )
        
//        phoneNumberTextField.addConstraints(
//            Constraint.tt.of(self, offset: screenHeight/4),
//            Constraint.llrr.of(self, offset: 50)
//        )
    }
}
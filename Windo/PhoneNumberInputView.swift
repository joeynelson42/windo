//
//  PhoneNumberInputView.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class PhoneNumberInputView: UIView {
    
    // MARK: Properties
    let numberPad = WindoNumberPad()
    
    let welcomeLabel = UILabel()
    let numberInputLabel = PhoneNumberInputLabel()
    
    let codeExplanationLabel = UILabel()
    let codeInputLabel = CodeInputLabel()
    
    let nextButton = UIButton()
    
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func transitionToCodeInput() {
        codeExplanationLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth - 100)
        )
        
        codeInputLabel.addConstraints(
            Constraint.cycy.of(numberInputLabel),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.43333)
        )
        
        welcomeLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self, offset: -screenWidth),
            Constraint.w.of(screenWidth - 100)
        )
        
        numberInputLabel.addConstraints(
            Constraint.tb.of(welcomeLabel, offset: 50),
            Constraint.cxcx.of(self, offset: -screenWidth),
            Constraint.w.of(screenWidth * 0.9)
        )
        
        UIView.animateWithDuration(0.6) {
            self.layoutIfNeeded()
        }
    }
    
    func transitionToPhoneInput() {
        codeExplanationLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self, offset: screenWidth),
            Constraint.w.of(screenWidth - 100)
        )
        
        codeInputLabel.addConstraints(
            Constraint.cycy.of(numberInputLabel),
            Constraint.cxcx.of(self, offset: screenWidth),
            Constraint.w.of(screenWidth * 0.43333)
        )
        
        welcomeLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth - 100)
        )
        
        numberInputLabel.addConstraints(
            Constraint.tb.of(welcomeLabel, offset: 50),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.9)
        )
        
        UIView.animateWithDuration(0.6) {
            self.layoutIfNeeded()
        }
    }
    
    func toggleNextButton(on: Bool) {
        var targetAlpha:CGFloat = 0.5
        if on {
            targetAlpha = 1.0
        }
        UIView.animateWithDuration(0.5) {
            self.nextButton.alpha = targetAlpha
        }
    }
    
    // MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightTeal()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        var attrString = NSMutableAttributedString(string: "Welcome to Windo.\nEnter your phone number to continue.")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        welcomeLabel.attributedText = attrString
        welcomeLabel.textColor = UIColor.whiteColor()
        welcomeLabel.font = UIFont.graphikRegular(20)
        welcomeLabel.textAlignment = .Center
        welcomeLabel.numberOfLines = 0
        
        attrString = NSMutableAttributedString(string: "Perfect!\nWe sent a code to you,\ncopy it here to enter Windo.")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        codeExplanationLabel.attributedText = attrString
        codeExplanationLabel.textColor = UIColor.whiteColor()
        codeExplanationLabel.font = UIFont.graphikRegular(20)
        codeExplanationLabel.textAlignment = .Center
        codeExplanationLabel.numberOfLines = 0
        
        nextButton.setTitle("NEXT", forState: .Normal)
        nextButton.setTitleColor(UIColor.lightTeal(), forState: .Normal)
        nextButton.setTitleColor(UIColor.darkTeal(), forState: .Highlighted)
        nextButton.titleLabel!.font = UIFont.graphikRegular(20)
        nextButton.backgroundColor = UIColor.whiteColor()
        nextButton.alpha = 0.5
        
        addSubview(welcomeLabel)
        addSubview(numberPad)
        addSubview(numberInputLabel)
        addSubview(codeInputLabel)
        addSubview(nextButton)
        addSubview(codeExplanationLabel)
    }
    
    func applyConstraints(){
        welcomeLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth - 100)
        )
            
        numberPad.addConstraints(
            Constraint.llrr.of(self, offset: 10),
            Constraint.tt.of(numberInputLabel, offset: 50)
        )
        
        numberInputLabel.addConstraints(
            Constraint.tb.of(welcomeLabel, offset: 50),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.9)
        )
        
        nextButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.llrr.of(self),
            Constraint.h.of(50)
        )
        
        codeExplanationLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self, offset: screenWidth)
        )
        
        codeInputLabel.addConstraints(
            Constraint.cycy.of(numberInputLabel),
            Constraint.cxcx.of(self, offset: screenWidth),
            Constraint.w.of(screenWidth * 0.43333)
        )
    }
}
//
//  NameInputView.swift
//  Windo
//
//  Created by Joey on 7/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class NameInputView: UIView, UITextFieldDelegate {
    
    // MARK: Properties
    let helpLabel = UILabel()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let enterButton = GHButton()
    var doneKeyboardAccessory = WindoKeyboardAccessoryView()
    
    // MARK: Inits
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
    
    // MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightTeal()
        
        helpLabel.font = UIFont.graphikRegular(20)
        helpLabel.text = "Oh, and by the way,\nwhat's your name?"
        helpLabel.numberOfLines = 0
        helpLabel.textColor = UIColor.whiteColor()
        helpLabel.textAlignment = .Center
        
        doneKeyboardAccessory = WindoKeyboardAccessoryView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50), state: ColorTheme(color: .teal))
        doneKeyboardAccessory.doneButton.addTarget(self, action: #selector(NameInputView.keyboardDismiss), forControlEvents: .TouchUpInside)
        doneKeyboardAccessory.leftArrowButton.addTarget(self, action: #selector(NameInputView.toggleBetweenTextFields), forControlEvents: .TouchUpInside)
        doneKeyboardAccessory.rightArrowButton.addTarget(self, action: #selector(NameInputView.toggleBetweenTextFields), forControlEvents: .TouchUpInside)
        
        firstNameTextField.font = UIFont.graphikRegular(35)
        firstNameTextField.backgroundColor = UIColor.clearColor()
        firstNameTextField.textColor = UIColor.whiteColor()
        firstNameTextField.placeholder = "First"
        firstNameTextField.tintColor = UIColor.whiteColor()
        firstNameTextField.textAlignment = .Center
        firstNameTextField.inputAccessoryView = doneKeyboardAccessory
        
        lastNameTextField.font = UIFont.graphikRegular(35)
        lastNameTextField.backgroundColor = UIColor.clearColor()
        lastNameTextField.textColor = UIColor.whiteColor()
        lastNameTextField.placeholder = "Last"
        lastNameTextField.tintColor = UIColor.whiteColor()
        lastNameTextField.textAlignment = .Center
        lastNameTextField.inputAccessoryView = doneKeyboardAccessory
        
        enterButton.setTitle("ENTER", forState: .Normal)
        enterButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        enterButton.titleLabel?.font = UIFont.graphikRegular(20)
        enterButton.layer.borderColor = UIColor.whiteColor().CGColor
        enterButton.layer.borderWidth = 1.5
        
        addSubview(helpLabel)
        addSubview(firstNameTextField)
        addSubview(lastNameTextField)
        addSubview(enterButton)
    }
    
    func applyConstraints(){
        
        helpLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.llrr.of(self, offset: 50)
        )
        
        firstNameTextField.addConstraints(
            Constraint.tb.of(helpLabel, offset: 45),
            Constraint.llrr.of(self, offset: 50)
        )
        
        lastNameTextField.addConstraints(
            Constraint.tb.of(firstNameTextField, offset: 10),
            Constraint.llrr.of(firstNameTextField)
        )
        
        enterButton.addConstraints(
            Constraint.tb.of(lastNameTextField, offset: 45),
            Constraint.cxcx.of(self),
            Constraint.w.of(150),
            Constraint.h.of(35)
        )
    }
    
    // MARK: KeyboardAccessory methods
    
    func keyboardDismiss() {
        self.endEditing(true)
    }
    
    func toggleBetweenTextFields(){
        if firstNameTextField.isFirstResponder() {
            lastNameTextField.becomeFirstResponder()
        }
        else {
            firstNameTextField.becomeFirstResponder()
        }
    }
}





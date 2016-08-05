//
//  AccountSettingsView.swift
//  Windo
//
//  Created by Joey on 8/3/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class AccountSettingsView: UIView {
    
    //MARK: Properties
    var firstNameLabel = UILabel()
    var firstNameTextField = UITextField()
    
    var lastNameLabel = UILabel()
    var lastNameTextField = UITextField()
    
    var phoneLabel = UILabel()
    var phoneTextField = UITextField()
    
    var emailLabel = UILabel()
    var emailTextField = UITextField()
    
    var keyboardAccessory = WindoKeyboardAccessoryView()

    var colorTheme: ColorTheme!
    
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
        let helpLabelFont = UIFont.graphikRegular(14)
        let helpLabelTextColor = UIColor.whiteColor()
        let helpLabelAlignment = NSTextAlignment.Right
        
        firstNameLabel.text = "First:"
        firstNameLabel.font = helpLabelFont
        firstNameLabel.textColor = helpLabelTextColor
        firstNameLabel.textAlignment = helpLabelAlignment
        
        lastNameLabel.text = "Last:"
        lastNameLabel.font = helpLabelFont
        lastNameLabel.textColor = helpLabelTextColor
        lastNameLabel.textAlignment = helpLabelAlignment
        
        phoneLabel.text = "Phone:"
        phoneLabel.font = helpLabelFont
        phoneLabel.textColor = helpLabelTextColor
        phoneLabel.textAlignment = helpLabelAlignment
        
        emailLabel.text = "Email:"
        emailLabel.font = helpLabelFont
        emailLabel.textColor = helpLabelTextColor
        emailLabel.textAlignment = helpLabelAlignment
        
        let textFieldFont = UIFont.graphikRegular(21)
        let textFieldColor = UIColor.whiteColor()
        let textFieldTintColor = colorTheme.lightColor
        
        firstNameTextField.font = textFieldFont
        firstNameTextField.textColor = textFieldColor
        firstNameTextField.text = "Yuki"
        firstNameTextField.tintColor = textFieldTintColor
        
        lastNameTextField.font = textFieldFont
        lastNameTextField.textColor = textFieldColor
        lastNameTextField.text = "Dorff"
        lastNameTextField.tintColor = textFieldTintColor
        
        phoneTextField.font = textFieldFont
        phoneTextField.textColor = textFieldColor
        phoneTextField.keyboardType = .NumberPad
        phoneTextField.tintColor = textFieldTintColor
        
        emailTextField.font = textFieldFont
        emailTextField.textColor = textFieldColor
        emailTextField.tintColor = textFieldTintColor
        
        keyboardAccessory = WindoKeyboardAccessoryView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50), state: colorTheme)
        keyboardAccessory.leftArrowButton.addTarget(.TouchUpInside) { 
            self.togglePreviousInput()
        }
        keyboardAccessory.rightArrowButton.addTarget(.TouchUpInside) { 
            self.toggleNextInput()
        }
        keyboardAccessory.doneButton.addTarget(.TouchUpInside) { 
            self.endEditing(true)
        }
        
        firstNameTextField.inputAccessoryView = keyboardAccessory
        lastNameTextField.inputAccessoryView = keyboardAccessory
        phoneTextField.inputAccessoryView = keyboardAccessory
        emailTextField.inputAccessoryView = keyboardAccessory
        
        addSubviews(firstNameLabel, lastNameLabel, phoneLabel, emailLabel)
        addSubviews(firstNameTextField, lastNameTextField, phoneTextField, emailTextField)
    }
    
    func applyConstraints(){
        firstNameTextField.addConstraints(
            Constraint.tt.of(self, offset: 11),
            Constraint.ll.of(self, offset: 66),
            Constraint.h.of(20),
            Constraint.w.of(screenWidth - 11)
        )
        
        firstNameLabel.addConstraints(
            Constraint.rl.of(firstNameTextField, offset: -7),
            Constraint.bb.of(firstNameTextField)
        )
        
        lastNameTextField.addConstraints(
            Constraint.tb.of(firstNameTextField, offset: 25),
            Constraint.ll.of(self, offset: 66),
            Constraint.h.of(20),
            Constraint.w.of(screenWidth - 11)
        )
        
        lastNameLabel.addConstraints(
            Constraint.rl.of(lastNameTextField, offset: -7),
            Constraint.bb.of(lastNameTextField)
        )
        
        phoneTextField.addConstraints(
            Constraint.tb.of(lastNameTextField, offset: 25),
            Constraint.ll.of(self, offset: 66),
            Constraint.h.of(20),
            Constraint.w.of(screenWidth - 11)
        )
        
        phoneLabel.addConstraints(
            Constraint.rl.of(phoneTextField, offset: -7),
            Constraint.bb.of(phoneTextField)
        )
        
        emailTextField.addConstraints(
            Constraint.tb.of(phoneLabel, offset: 25),
            Constraint.ll.of(self, offset: 66),
            Constraint.h.of(20),
            Constraint.w.of(screenWidth - 11)
        )
        
        emailLabel.addConstraints(
            Constraint.rl.of(emailTextField, offset: -7),
            Constraint.bb.of(emailTextField)
        )
    }
    
    // MARK: Methods
    func toggleNextInput() {
        if firstNameTextField.isFirstResponder() {
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder() {
            phoneTextField.becomeFirstResponder()
        } else if phoneTextField.isFirstResponder() {
            emailTextField.becomeFirstResponder()
        } else if emailTextField.isFirstResponder() {
            firstNameTextField.becomeFirstResponder()
        }
    }
    
    func togglePreviousInput() {
        if firstNameTextField.isFirstResponder() {
            emailTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder() {
            firstNameTextField.becomeFirstResponder()
        } else if phoneTextField.isFirstResponder() {
            lastNameTextField.becomeFirstResponder()
        } else if emailTextField.isFirstResponder() {
            phoneTextField.becomeFirstResponder()
        }
    }
    
    // MARK: Utilities
    
}
//
//  CreateEventView.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class CreateEventView: UIView, UITextFieldDelegate {
    
    //MARK: Properties

    //invitees
    var inviteeCell = UIView()
    var inviteeLabel = UILabel()
    let inviteePlaceholderText = "Invite friends!"
    
    //location
    var locationCell = UIView()
    var locationTitleLabel = UILabel()
    var locationTextField = UITextField()
    
    //name
    var nameCell = UIView()
    var nameTitleLabel = UILabel()
    var nameTextField = UITextField()
    
    //cellSeparators
    var inviteeSeparator = UIView()
    var locationSeparator = UIView()
    var nameSeparator = UIView()
    
    //calendar!
    var calendarContainer = WindoCalendarView()
    
    //misc
    var setAvailabilityButton = UIButton()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        backgroundColor = UIColor.blue()
        let keyboardDismiss = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.keyboardDismiss))
        addGestureRecognizer(keyboardDismiss)
        
        inviteeCell.backgroundColor = UIColor.lightBlue()
        
        locationCell.backgroundColor = UIColor.lightBlue()
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.locationTapped))
        locationCell.addGestureRecognizer(locationTap)
        
        locationTitleLabel.text = "Location"
        locationTitleLabel.font = UIFont.graphikRegular(14)
        locationTitleLabel.textColor = UIColor.darkBlue()
        
        locationTextField.textColor = UIColor.whiteColor()
        locationTextField.font = UIFont.graphikRegular(16)
        locationTextField.tintColor = UIColor.whiteColor()
        locationTextField.tag = 0
        locationTextField.delegate = self
        
        nameCell.backgroundColor = UIColor.lightBlue()
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.nameTapped))
        nameCell.addGestureRecognizer(nameTap)
        
        nameTitleLabel.text = "Name"
        nameTitleLabel.font = UIFont.graphikRegular(14)
        nameTitleLabel.textColor = UIColor.darkBlue()
        
        nameTextField.textColor = UIColor.whiteColor()
        nameTextField.font = UIFont.graphikRegular(16)
        nameTextField.tintColor = UIColor.whiteColor()
        nameTextField.tag = 1
        nameTextField.delegate = self
        
        inviteeLabel.textColor = UIColor.whiteColor()
        inviteeLabel.font = UIFont.graphikRegular(18)
        inviteeLabel.tintColor = UIColor.whiteColor()
        inviteeLabel.tag = 2
        
        inviteeSeparator.backgroundColor = UIColor.darkBlue()
        locationSeparator.backgroundColor = UIColor.darkBlue()
        nameSeparator.backgroundColor = UIColor.darkBlue()
        
        setAvailabilityButton.setTitle("Set Availability", forState: .Normal)
        setAvailabilityButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setAvailabilityButton.titleLabel?.font = UIFont.graphikRegular(20)
        setAvailabilityButton.backgroundColor = UIColor.darkBlue()
        
        //Calendar
        calendarContainer.backgroundColor = UIColor.blue()
                
        addSubview(inviteeCell)
        addSubview(locationCell)
        addSubview(nameCell)
        addSubviews(inviteeSeparator, locationSeparator, nameSeparator)
        addSubview(inviteeLabel)
        addSubview(locationTextField)
        addSubview(locationTitleLabel)
        addSubview(nameTextField)
        addSubview(nameTitleLabel)
        addSubview(calendarContainer)
        addSubview(setAvailabilityButton)
    }
    
    func applyConstraints(){
        
        inviteeCell.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        
        inviteeSeparator.addConstraints(
            Constraint.tb.of(inviteeCell, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(2)
        )
        
        inviteeLabel.addConstraints(
            Constraint.cycy.of(inviteeCell),
            Constraint.ll.of(self, offset: 18),
            Constraint.w.of(screenWidth),
            Constraint.h.of(18)
        )
        
        locationCell.addConstraints(
            Constraint.tb.of(inviteeCell),
            Constraint.ll.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        
        locationSeparator.addConstraints(
            Constraint.tb.of(locationCell, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(2)
        )
        
        locationTitleLabel.addConstraints(
            Constraint.tt.of(self, offset: 81),
            Constraint.ll.of(self, offset: 16),
            Constraint.w.of(100),
            Constraint.h.of(16)
        )
        
        locationTextField.addConstraints(
            Constraint.tt.of(self, offset: 85),
            Constraint.ll.of(self, offset: 16),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )

        nameCell.addConstraints(
            Constraint.tb.of(locationCell),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        
        nameSeparator.addConstraints(
            Constraint.tb.of(nameCell, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(2)
        )

        nameTitleLabel.addConstraints(
            Constraint.tb.of(locationTitleLabel, offset: 45),
            Constraint.ll.of(self, offset: 16),
            Constraint.w.of(100),
            Constraint.h.of(16)
        )

        nameTextField.addConstraints(
            Constraint.tb.of(locationTextField, offset: 45),
            Constraint.ll.of(self, offset: 16),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )
        
        calendarContainer.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tb.of(nameCell, offset: 2),
            Constraint.w.of(screenWidth),
            Constraint.h.of(91 + calendarContainer.daySize * 5)
        )
        
        setAvailabilityButton.addConstraints(
            Constraint.tb.of(calendarContainer, offset: 10),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let moveUp = CGAffineTransformMakeTranslation(-9, -20)
        let shrink = CGAffineTransformMakeScale(0.85, 0.85)
        
        switch(textField.tag){
        case 0:
            UIView.animateWithDuration(0.15, animations: { Void in
                self.locationTitleLabel.transform = CGAffineTransformConcat(moveUp, shrink)
            })
        case 1:
            UIView.animateWithDuration(0.15, animations: { Void in
                self.nameTitleLabel.transform = CGAffineTransformConcat(moveUp, shrink)
            })
//        case 2:
//            if textField.text == inviteePlaceholderText{ textField.text = "" }
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let moveDown = CGAffineTransformMakeTranslation(0, 0)
        let grow = CGAffineTransformMakeScale(1.0, 1.0)
        
        switch(textField.tag){
        case 0:
            if textField.text != ""{ return }
            UIView.animateWithDuration(0.15, animations: { Void in
                self.locationTitleLabel.transform = CGAffineTransformConcat(moveDown, grow)
            })
        case 1:
            if textField.text != ""{ return }
            UIView.animateWithDuration(0.15, animations: { Void in
                self.nameTitleLabel.transform = CGAffineTransformConcat(moveDown, grow)
            })
        default:
            break
        }
    }
    
    func keyboardDismiss(){
        endEditing(true)
    }
    
    func nameTapped(){
        nameTextField.becomeFirstResponder()
    }
    
    func locationTapped(){
        locationTextField.becomeFirstResponder()
    }
    
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = convertRect(rawFrame, fromView: nil)
        keyboardHeight = keyboardFrame.height
        print("keyboardFrame: \(keyboardFrame)")
    }
}





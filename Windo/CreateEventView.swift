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
    let inviteePlaceholderText = "Name, @username, email"
//    var inviteeStackView = UIStackView()
    
    //location
    var locationCell = UIView()
    var locationTitleLabel = UILabel()
    var locationTextField = UITextField()
    
    //name
    var nameCell = UIView()
    var nameTitleLabel = UILabel()
    var nameTextField = UITextField()
    
    //calendar!
    var calendarContainer = WindoCalendarView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        backgroundColor = UIColor.lightBlue()
        let keyboardDismiss = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.keyboardDismiss))
        addGestureRecognizer(keyboardDismiss)
        
        inviteeCell.backgroundColor = UIColor.clearColor()
        
        locationCell.backgroundColor = UIColor.clearColor()
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
        
        nameCell.backgroundColor = UIColor.clearColor()
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
        
        //Calendar
        calendarContainer.backgroundColor = UIColor.blue()
        
        addSubview(inviteeCell)
        addSubview(locationCell)
        addSubview(nameCell)
        addSubview(inviteeLabel)
        addSubview(locationTextField)
        addSubview(locationTitleLabel)
        addSubview(nameTextField)
        addSubview(nameTitleLabel)
        addSubview(calendarContainer)
    }
    
    func applyConstraints(){
        inviteeCell.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 0),
            Constraint.ll : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 60)])
        
        inviteeLabel.constrainUsing(constraints: [
            Constraint.cycy : (of: inviteeCell, offset: 0),
            Constraint.ll : (of: self, offset: 18),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 18)])
        
        locationTitleLabel.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 81),
            Constraint.ll : (of: self, offset: 16),
            Constraint.w : (of: nil, offset: 100),
            Constraint.h : (of: nil, offset: 16)])
        
        locationTextField.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 85),
            Constraint.ll : (of: self, offset: 16),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 16)])
        
        locationCell.constrainUsing(constraints: [
            Constraint.tb : (of: inviteeCell, offset: 0),
            Constraint.ll : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 60)])
        
        nameTitleLabel.constrainUsing(constraints: [
            Constraint.tb : (of: locationTitleLabel, offset: 45),
            Constraint.ll : (of: self, offset: 16),
            Constraint.w : (of: nil, offset: 100),
            Constraint.h : (of: nil, offset: 16)])
        
        nameTextField.constrainUsing(constraints: [
            Constraint.tb : (of: locationTextField, offset: 45),
            Constraint.ll : (of: self, offset: 16),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 16)])
        
        nameCell.constrainUsing(constraints: [
            Constraint.tb : (of: locationCell, offset: 0),
            Constraint.ll : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 60)])
        
        calendarContainer.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tb.of(nameCell, offset: 1),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
    }
    
    override func drawRect(rect: CGRect) {
        for i in 1...3 {
            let y: CGFloat = CGFloat(i * 60)
            let startPoint = CGPoint(x: 0, y: y)
            let endPoint = CGPoint(x: screenWidth, y: y)
            
            let plusPath = UIBezierPath()
            plusPath.lineWidth = 2.0
            UIColor.darkBlue().setStroke()
            
            plusPath.moveToPoint(startPoint)
            plusPath.addLineToPoint(endPoint)
            
            plusPath.stroke()
        }
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





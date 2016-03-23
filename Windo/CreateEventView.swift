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
    var inviteeTextField = UITextField()
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
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        backgroundColor = UIColor.blue()
        let keyboardDismiss = UITapGestureRecognizer(target: self, action: "keyboardDismiss")
        addGestureRecognizer(keyboardDismiss)
        
        inviteeCell.backgroundColor = UIColor.clearColor()
        
        locationCell.backgroundColor = UIColor.clearColor()
        let locationTap = UITapGestureRecognizer(target: self, action: "locationTapped")
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
        let nameTap = UITapGestureRecognizer(target: self, action: "nameTapped")
        nameCell.addGestureRecognizer(nameTap)
        
        nameTitleLabel.text = "Name"
        nameTitleLabel.font = UIFont.graphikRegular(14)
        nameTitleLabel.textColor = UIColor.darkBlue()
        
        nameTextField.textColor = UIColor.whiteColor()
        nameTextField.font = UIFont.graphikRegular(16)
        nameTextField.tintColor = UIColor.whiteColor()
        nameTextField.tag = 1
        nameTextField.delegate = self
        
        inviteeTextField.textColor = UIColor.whiteColor()
        inviteeTextField.font = UIFont.graphikRegular(18)
        inviteeTextField.tintColor = UIColor.whiteColor()
        inviteeTextField.text = inviteePlaceholderText
        inviteeTextField.tag = 2
        inviteeTextField.delegate = self

        addSubview(inviteeCell)
        addSubview(inviteeTextField)
        addSubview(locationTextField)
        addSubview(locationTitleLabel)
        addSubview(locationCell)
        addSubview(nameTextField)
        addSubview(nameTitleLabel)
        addSubview(nameCell)
    }
    
    func applyConstraints(){
        inviteeCell.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 64),
            Constraint.ll : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 60)])
        
        inviteeTextField.constrainUsing(constraints: [
            Constraint.cycy : (of: inviteeCell, offset: 0),
            Constraint.ll : (of: self, offset: 18),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 18)])
        
        locationTitleLabel.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 145),
            Constraint.ll : (of: self, offset: 16),
            Constraint.w : (of: nil, offset: 100),
            Constraint.h : (of: nil, offset: 16)])
        
        locationTextField.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 149),
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
    }
    
    override func drawRect(rect: CGRect) {
        for i in 1...3 {
            let y: CGFloat = CGFloat(i * 60) + 64
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
//        case 2:
//            if textField.text == ""{
//                textField.text = inviteePlaceholderText
//            }
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





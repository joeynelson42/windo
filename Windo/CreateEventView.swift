//
//  CreateEventView.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class CreateEventView: UIView, UITextFieldDelegate {
    
    //MARK: Properties

    //invitees
    var inviteeTableView = UITableView()
    var tokenBar = VENTokenField()
    var collapsedCell = UIView()
    var collapsedLabel = UILabel()
    
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
//    var calendarContainer = WindoCalendarView()
    let calendar = FSCalendar()
    
    //misc
    var doneKeyboardAccessory = WindoKeyboardAccessoryView()
    let cellSize = screenHeight * 0.08995502
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        backgroundColor = UIColor.blue()
        
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.blue()
        
        calendar.calendarHeaderView.backgroundColor = UIColor.blue()
        calendar.calendarWeekdayView.backgroundColor = UIColor.blue()
        
        calendar.appearance.headerTitleFont = UIFont.graphikRegular(18)
        calendar.appearance.headerTitleColor = .extraDarkBlue()
        
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.titleOffset = CGPoint(x:0, y: 4)
        
        calendar.appearance.weekdayTextColor = .extraDarkBlue()
        calendar.appearance.weekdayFont = UIFont.graphikRegular(10)
        calendar.appearance.adjustsFontSizeToFitContentSize = false
        
        calendar.clipsToBounds = true // Remove top/bottom line
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        calendar.swipeToChooseGesture.minimumPressDuration = 0.25
        
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        
        for (index,label) in calendar.calendarWeekdayView.weekdayLabels.allObjects.enumerated() {
            switch index {
            case 0:
                label.text = "S"
            case 1:
                label.text = "M"
            case 2:
                label.text = "T"
            case 3:
                label.text = "W"
            case 4:
                label.text = "Th"
            case 5:
                label.text = "F"
            case 6:
                label.text = "S"
            default:
                print("no more days")
            }
        }
        
        inviteeTableView.backgroundColor = UIColor.darkBlue()
        inviteeTableView.showsVerticalScrollIndicator = false
        inviteeTableView.separatorColor = UIColor.blue()
        inviteeTableView.register(InviteeCell.self, forCellReuseIdentifier: "inviteeCell")
        inviteeTableView.register(InviteeHeaderCell.self, forHeaderFooterViewReuseIdentifier: "inviteeHeaderCell")
        inviteeTableView.isHidden = true
        
        tokenBar.delimiters = [",", ";", "--"]
        tokenBar.placeholderText = ""
        tokenBar.backgroundColor = UIColor.lightBlue()
        tokenBar.toLabelText = ""
        tokenBar.setColorScheme(UIColor.white)
        tokenBar.toLabelTextColor = UIColor.darkBlue()
        tokenBar.inputTextFieldTextColor = UIColor.white
        
        collapsedCell.backgroundColor = UIColor.lightBlue()
        collapsedCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateEventView.toggleTokenBar)))
        
        collapsedLabel.font = UIFont.graphikRegular(16)
        collapsedLabel.textColor = UIColor.white
        collapsedLabel.text = "Invite some friends!"
        collapsedLabel.backgroundColor = UIColor.lightBlue()
        
        locationCell.backgroundColor = UIColor.lightBlue()
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.locationTapped))
        locationCell.addGestureRecognizer(locationTap)
        
        locationTitleLabel.text = "Event Location"
        locationTitleLabel.font = UIFont.graphikRegular(16)
        locationTitleLabel.textColor = UIColor.darkBlue()
        
        locationTextField.textColor = UIColor.white
        locationTextField.font = UIFont.graphikRegular(16)
        locationTextField.tintColor = UIColor.white
        locationTextField.tag = 0
        locationTextField.delegate = self
        
        nameCell.backgroundColor = UIColor.lightBlue()
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(CreateEventView.nameTapped))
        nameCell.addGestureRecognizer(nameTap)
        
        nameTitleLabel.text = "Event Name"
        nameTitleLabel.font = UIFont.graphikRegular(16)
        nameTitleLabel.textColor = UIColor.darkBlue()
        
        nameTextField.textColor = UIColor.white
        nameTextField.font = UIFont.graphikRegular(16)
        nameTextField.tintColor = UIColor.white
        nameTextField.tag = 1
        nameTextField.delegate = self
        
        inviteeSeparator.backgroundColor = UIColor.darkBlue()
        locationSeparator.backgroundColor = UIColor.darkBlue()
        nameSeparator.backgroundColor = UIColor.darkBlue()
        
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let timesTitle = NSMutableAttributedString(string: "Specify Times", attributes: underlineAttribute)
        timesTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, timesTitle.length))
        
        doneKeyboardAccessory = WindoKeyboardAccessoryView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50), state: ColorTheme(color: .blue))
        locationTextField.inputAccessoryView = doneKeyboardAccessory
        nameTextField.inputAccessoryView = doneKeyboardAccessory
        
        doneKeyboardAccessory.doneButton.addTarget(self, action: #selector(CreateEventView.keyboardDismiss), for: .touchUpInside)
        
        doneKeyboardAccessory.leftArrowButton.addTarget(self, action: #selector(CreateEventView.toggleBetweenTextFields), for: .touchUpInside)
        
        doneKeyboardAccessory.rightArrowButton.addTarget(self, action: #selector(CreateEventView.toggleBetweenTextFields), for: .touchUpInside)
        
        //Calendar
//        calendarContainer.backgroundColor = UIColor.blue()
        
        addSubview(locationCell)
        addSubview(nameCell)
        addSubviews(inviteeSeparator, locationSeparator, nameSeparator)
        addSubview(locationTextField)
        addSubview(locationTitleLabel)
        addSubview(nameTextField)
        addSubview(nameTitleLabel)
//        addSubview(calendarContainer)
        addSubview(calendar)
        
        addSubview(tokenBar)
        addSubview(inviteeTableView)
        addSubview(collapsedCell)
        collapsedCell.addSubview(collapsedLabel)
    }
    
    func applyConstraints(){
        
        tokenBar.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        collapsedCell.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        collapsedLabel.addConstraints(
            Constraint.cycy.of(collapsedCell),
            Constraint.ll.of(collapsedCell, offset: 20),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        inviteeTableView.addConstraints(
            Constraint.tb.of(tokenBar),
            Constraint.bb.of(self),
            Constraint.llrr.of(self),
            Constraint.w.of(screenWidth)
        )
        
        inviteeSeparator.addConstraints(
            Constraint.tb.of(tokenBar),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(1)
        )
        
        locationCell.addConstraints(
            Constraint.tb.of(tokenBar),
            Constraint.ll.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        locationSeparator.addConstraints(
            Constraint.tb.of(locationCell, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(1)
        )
        
        locationTitleLabel.addConstraints(
            Constraint.cycy.of(locationCell),
            Constraint.ll.of(self, offset: 20),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )
        
        locationTextField.addConstraints(
            Constraint.cycy.of(locationCell),
            Constraint.ll.of(self, offset: 20),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )

        nameCell.addConstraints(
            Constraint.tb.of(locationCell),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        nameSeparator.addConstraints(
            Constraint.tb.of(nameCell, offset: -1),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(1)
        )

        nameTitleLabel.addConstraints(
            Constraint.cycy.of(nameCell),
            Constraint.ll.of(self, offset: 20),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )

        nameTextField.addConstraints(
            Constraint.cycy.of(nameCell),
            Constraint.ll.of(self, offset: 20),
            Constraint.w.of(screenWidth),
            Constraint.h.of(16)
        )
        
        
        calendar.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tb.of(nameCell, offset: 2),
            Constraint.llrr.of(self),
            Constraint.bb.of(self)
//            Constraint.h.of(calendarContainer.calendarHeight())
        )

//
//        calendarContainer.addConstraints(
//            Constraint.cxcx.of(self),
//            Constraint.tb.of(nameCell, offset: 2),
//            Constraint.w.of(screenWidth),
//            Constraint.h.of(calendarContainer.calendarHeight())
//        )
    }
    
    func toggleTokenBar() {
        tokenBar.becomeFirstResponder()
    }
    
    func hideTableView(_ firstInviteeName: String, numberOfInvitees: Int) {
        tokenBar.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(cellSize)
        )
        
        switch numberOfInvitees {
        case 0:
            collapsedLabel.text = "Invite some friends!"
        case 1:
            collapsedLabel.text = firstInviteeName
        case 2:
            collapsedLabel.text = "\(firstInviteeName) and 1 other"
        default:
            collapsedLabel.text = "\(firstInviteeName) and \(numberOfInvitees - 1) others"
        }
        
        self.layoutIfNeeded()
        self.inviteeTableView.isHidden = true
        self.collapsedCell.isHidden = false

        endEditing(true)
    }
    
    func showTableView() {
        inviteeTableView.isHidden = false
        collapsedCell.isHidden = true
        tokenBar.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        let moveUp = CGAffineTransformMakeTranslation(-18, -20)
//        let shrink = CGAffineTransformMakeScale(0.85, 0.85)
        
        switch(textField.tag) {
        case 0:
            locationTitleLabel.isHidden = true
//            UIView.animateWithDuration(0.15, animations: { Void in
//                self.locationTitleLabel.transform = CGAffineTransformConcat(moveUp, shrink)
//                self.locationTitleLabel.alpha = 0.75
//            })
        case 1:
            nameTitleLabel.isHidden = true
//            UIView.animateWithDuration(0.15, animations: { Void in
//                self.nameTitleLabel.transform = CGAffineTransformConcat(moveUp, shrink)
//                self.nameTitleLabel.alpha = 0.75
//            })
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != ""{ return }
//        let moveDown = CGAffineTransformMakeTranslation(0, 0)
//        let grow = CGAffineTransformMakeScale(1.0, 1.0)
        
        switch(textField.tag){
        case 0:
            locationTitleLabel.isHidden = false
//            UIView.animateWithDuration(0.15, animations: { Void in
//                self.locationTitleLabel.transform = CGAffineTransformConcat(moveDown, grow)
//                self.locationTitleLabel.alpha = 1.0
//            })
        case 1:
            nameTitleLabel.isHidden = false
//            UIView.animateWithDuration(0.15, animations: { Void in
//                self.nameTitleLabel.transform = CGAffineTransformConcat(moveDown, grow)
//                self.nameTitleLabel.alpha = 1.0
//            })
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            if textField.text?.characters.count < eventNameMaxLength {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    func toggleBetweenTextFields(){
        if nameTextField.isFirstResponder {
            locationTextField.becomeFirstResponder()
        }
        else {
            nameTextField.becomeFirstResponder()
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
    
    func keyboardShown(_ notification: Notification) {
        let info  = (notification as NSNotification).userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        
        let rawFrame = value.cgRectValue
        let keyboardFrame = convert(rawFrame!, from: nil)
        keyboardHeight = keyboardFrame.height
    }
}





//
//  PhoneNumberInputViewController.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class PhoneNumberInputViewController: UIViewController, WindoNumberPadDelegate {
    
    //MARK: Properties
    
    var inputNumberView = PhoneNumberInputView()
    var phoneNumber = "" {
        didSet {
            numberLength = phoneNumber.characters.count
        }
    }
    
    var numberLength = 0
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = inputNumberView
        inputNumberView.numberPad.delegate = self
    }
    
    func numberTapped(number: Int) {
//        if number == -1 {
//            backspace()
//        } else {
//            addNumber(number)
//        }
//        
//        inputNumberView.phoneNumberTextField.textFieldTextDidChange()
    }
    
//    func addNumber(number: Int) {
//        if numberLength == 14 {
//            // shake animate
//            return
//        } else if numberLength == 0 {
//            phoneNumber.append(Character("("))
//        }
//        
//        let numberString = String(number)
//        let char = Character(numberString)
//        phoneNumber.append(char)
//
//        switch numberLength {
//        case 4:
//            phoneNumber.append(Character(")"))
//            phoneNumber.append(Character(" "))
//        case 9:
//            phoneNumber.append(Character("-"))
//        default:
//            break
//        }
//        
//        inputNumberView.phoneNumberTextField.setText(phoneNumber)
//    }
//    
//    func backspace() {
//        let length = phoneNumber.characters.count
//        if length == 0 {
//            // shake animate
//            return
//        }
//        
//        let lastIndex = phoneNumber.startIndex.advancedBy(length - 1)
//        let char = phoneNumber.removeAtIndex(lastIndex)
//        if !String(char).isAlpha() || numberLength == 1{
//            backspace()
//        }
//        
//        inputNumberView.phoneNumberTextField.setText(phoneNumber)
//    }
}
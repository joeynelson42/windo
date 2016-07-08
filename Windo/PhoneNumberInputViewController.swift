//
//  PhoneNumberInputViewController.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum InputState {
    case phoneNumber
    case code
}

class PhoneNumberInputViewController: UIViewController, WindoNumberPadDelegate {
    
    //MARK: Properties
    let authy = AuthManager()
    
    var state: InputState = .phoneNumber
    
    var inputNumberView = PhoneNumberInputView()
    var phoneNumber = "" {
        didSet {
            numberLength = phoneNumber.characters.count
        }
    }
    
    var numberLength = 0 {
        didSet {
            if numberLength == 10 {
                inputNumberView.toggleNextButton(true)
            } else if numberLength == 9 {
                inputNumberView.toggleNextButton(false)
            }
        }
    }
    
    var code = "" {
        didSet {
            codeLength = code.characters.count
        }
    }
    
    var codeLength = 0 {
        didSet {
            if codeLength == 6 {
                inputNumberView.toggleNextButton(true)
            } else if codeLength == 5 {
                inputNumberView.toggleNextButton(false)
            }
        }
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = inputNumberView
        inputNumberView.numberPad.delegate = self
        
        addTargets()
    }
    
    func addTargets() {
        inputNumberView.nextButton.addTarget(self, action: #selector(PhoneNumberInputViewController.toggleState), forControlEvents: .TouchUpInside)
    }
    
    func numberTapped(number: Int) {
        if number == -1 {
            backspace(number)
        } else {
            addNumber(number)
        }
    }
    
    func addNumber(number: Int) {
        switch state {
        case .phoneNumber:
            if numberLength < 10 {
                phoneNumber = "\(phoneNumber)\(String(number))"
                inputNumberView.numberInputLabel.setNumberForIndex(String(number), index: numberLength)
            } else {
                print("shake shake!")
            }
        case .code:
            if codeLength < 6 {
                code = "\(code)\(String(number))"
                inputNumberView.codeInputLabel.setNumberForIndex(String(number), index: codeLength)
            } else {
                print("shake shake!")
            }
        }
    }

    func backspace(number: Int) {
        switch state {
        case .phoneNumber:
            if numberLength == 0 {
                print("shake shake!")
                return
            }
            phoneNumber.removeAtIndex(phoneNumber.endIndex.predecessor())
            inputNumberView.numberInputLabel.removeLastInput()
        case .code:
            if codeLength == 0 {
                print("shake shake!")
                return
            }
            code.removeAtIndex(code.endIndex.predecessor())
            inputNumberView.codeInputLabel.removeLastInput()
        }
    }
    
    func toggleState() {
        if state == .code {
            transitionToPhoneNumber()
        } else {
            transitionToCode()
        }
    }
    
    func transitionToCode() {
        sendAuthCode()
        state = .code
    }
    
    func transitionToPhoneNumber() {
        state = .phoneNumber
    }
    
    // MARK: AuthManager methods
    func sendAuthCode() {
        if numberLength != 10 {
            return
        }
        
        authy.createAuthCode()
        authy.sendSMS(phoneNumber) { (success) in
            if success {
                print("success!")
            } else {
                print("failure!")
            }
        }
    }
}









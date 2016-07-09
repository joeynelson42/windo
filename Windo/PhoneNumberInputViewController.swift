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
    case loading
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
        inputNumberView.nextButton.addTarget(self, action: #selector(PhoneNumberInputViewController.executeNext), forControlEvents: .TouchUpInside)
        inputNumberView.goBackButton.addTarget(self, action: #selector(PhoneNumberInputViewController.goBack), forControlEvents: .TouchUpInside)
    }
    
    // MARK: WindoNumberPadDelegate Methods
    func numberTapped(number: Int) {
        if number == -1 {
            backspace(number)
        } else {
            addNumber(number)
        }
    }
    
    // MARK: Label Manipulation Methods
    func addNumber(number: Int) {
        switch state {
        case .phoneNumber:
            if numberLength < 10 {
                phoneNumber = "\(phoneNumber)\(String(number))"
                inputNumberView.numberInputLabel.setNumberForIndex(String(number), index: numberLength)
            } else {
                inputNumberView.numberInputLabel.shake()
            }
        case .code:
            if codeLength < 6 {
                code = "\(code)\(String(number))"
                inputNumberView.codeInputLabel.setNumberForIndex(String(number), index: codeLength)
            } else {
                inputNumberView.codeInputLabel.shake()
            }
        default:
            return
        }
    }

    func backspace(number: Int) {
        switch state {
        case .phoneNumber:
            if numberLength == 0 {
                inputNumberView.numberInputLabel.shake()
                return
            }
            phoneNumber.removeAtIndex(phoneNumber.endIndex.predecessor())
            inputNumberView.numberInputLabel.removeLastInput()
        case .code:
            if codeLength == 0 {
                inputNumberView.codeInputLabel.shake()
                return
            }
            code.removeAtIndex(code.endIndex.predecessor())
            inputNumberView.codeInputLabel.removeLastInput()
        default:
            return
        }
    }
    
    func clearPhoneNumber() {
        phoneNumber = ""
        inputNumberView.numberInputLabel.clearAll()
    }
    
    func clearCode() {
        code = ""
        inputNumberView.codeInputLabel.clearAll()
    }
    
    // MARK: Flow

    func toggleAnimate() {
        switch state {
        case .phoneNumber:
            inputNumberView.hidePhoneInput()
            inputNumberView.showLoading()
            state = .loading
        case .loading:
            inputNumberView.hideLoading()
            inputNumberView.showCodeInput()
            inputNumberView.showGoBack()
            state = .code
        case .code:
            inputNumberView.hideCodeInput()
            inputNumberView.showPhoneInput()
            inputNumberView.hideGoBack()
            state = .phoneNumber
        }
    }
    
    func executeNext() {
        switch state {
        case .phoneNumber:
            if numberLength == 10 {
                enterLoadingState()
            }
        case .loading:
            enterCodeInputState()
        case .code:
            if verifyCode() {
                // enter app!
                print("successful!")
            } else {
                // incorrect code, give option to resend/go back
                print("failed")
            }
        }
    }
    
    func goBack() {
        clearCode()
        authy.resetAuthCode()
        inputNumberView.toggleNextButton(true)
        enterPhoneInputState()
    }
    
    func enterLoadingState() {
        inputNumberView.hidePhoneInput()
        inputNumberView.showLoading()
        sendAuthCode { (success) in
            if success {
                self.state = .loading
                self.executeNext()
            } else {
                print("error sending message")
            }
        }
    }
    
    func enterCodeInputState() {
        inputNumberView.hideLoading()
        inputNumberView.showCodeInput()
        inputNumberView.showGoBack()
        inputNumberView.toggleNextButton(false)
        state = .code
    }
    
    func enterPhoneInputState() {
        inputNumberView.hideCodeInput()
        inputNumberView.showPhoneInput()
        inputNumberView.hideGoBack()
        state = .phoneNumber
    }
    
    func verifyCode() -> Bool {
        if codeLength != 6 {
            return false
        } else {
            return authy.verifyCode(code)
        }
    }
    
    // MARK: AuthManager methods
    func sendAuthCode(completion: (success: Bool) -> Void) {
        if numberLength != 10 {
            return
        }
        
        authy.createAuthCode()
        authy.sendSMS(phoneNumber) { (success) in
            completion(success: success)
        }
    }
}









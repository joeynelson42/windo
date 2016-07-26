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
    case name
}

class PhoneNumberInputViewController: UIViewController, WindoNumberPadDelegate, Alerts {
    
    //MARK: Properties
    let authy = AuthManager()
    var alert = WindoAlertView()
    
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
        inputNumberView.nameInputView.enterButton.addTarget(self, action: #selector(PhoneNumberInputViewController.executeNext), forControlEvents: .TouchUpInside)
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
                // if user isn't new then enter app
                
                
                inputNumberView.showNameInput()
                state = .name
            } else {
                // incorrect code, give option to resend/go back
                inputNumberView.codeInputLabel.shake()
            }
        case .name:
            view.endEditing(true)
            
            if inputNumberView.nameInputView.firstNameTextField.text == "" ||
                inputNumberView.nameInputView.lastNameTextField.text == "" {
                // TODO: show alert for incomplete name field(s)
                return
            } else {
                finishInfoInput()
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
        self.state = .loading
        sendAuthCode { (success) in
            if success {
                self.executeNext()
            } else {
                print("error sending message")
                self.enterPhoneInputState()
            }
        }
    }
    
    func enterCodeInputState() {
        // had to call this on main queue because the twilio messaging throws something off with the threading
        dispatch_async(dispatch_get_main_queue()) {
            self.inputNumberView.hideLoading()
            self.inputNumberView.showCodeInput()
            self.inputNumberView.showGoBack()
            self.inputNumberView.toggleNextButton(false)
        }
        state = .code
    }
    
    func enterPhoneInputState() {
        inputNumberView.hideCodeInput()
        inputNumberView.showPhoneInput()
        inputNumberView.hideGoBack()
        state = .phoneNumber
    }
    
    func finishInfoInput() {
        let userFromInput = User(id: "",
                        number: phoneNumber,
                        email: "",
                        facebookID: "",
                        googleID: "",
                        firstName: inputNumberView.nameInputView.firstNameTextField.text!,
                        lastName: inputNumberView.nameInputView.firstNameTextField.text!,
                        imageRecordID: "")
        
        AppController.sharedController.showSplashScreen(UIColor.lightTeal(), fadeIn: true)
        CloudManager.sharedManager.getUserWithPhoneNumber(phoneNumber, completionHandler: { (success, user) in
            if success {
                let homeVC = HomeViewController()
                let navVC = UINavigationController(rootViewController: homeVC)
                AppController.sharedController.displayContentController(navVC)
                AppController.sharedController.hideSplashScreen()
            } else {
                CloudManager.sharedManager.saveNewUser(userFromInput, completionHandler: { (user, success) in
                    if success {
                        let homeVC = HomeViewController()
                        let navVC = UINavigationController(rootViewController: homeVC)
                        AppController.sharedController.displayContentController(navVC)
                        AppController.sharedController.hideSplashScreen()
                    } else {
                        // handle failed save
                    }
                })
            }
        })
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
//    
//    // MARK: Alert/Error handling
//    func showIncorrectCodeAlert() {
//        alert = WindoAlertView(color: UIColor.teal(), message: "Sorry!\nThat isn't correct, would you like to resend the message? Or maybe check your phone number?")
//        
//        alert.addAction(WindoButtonType.destructive, title: "Resend Code") {
//            self.hideAlert(self.alert)
//            self.sendAuthCode({ (success) in
//                print(success)
//            })
//        }
//        
//        alert.addAction(WindoButtonType.simple, title: "Check phone number") {
//            self.hideAlert(self.alert)
//            self.goBack()
//        }
//        
//        alert.addAction(WindoButtonType.secondary, title: "Cancel") { 
//            self.hideAlert(self.alert)
//        }
//        
//        inputNumberView.addSubview(alert)
//        
//        showAlert(alert)
//    }
}
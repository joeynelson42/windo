//
//  PhoneNumberInputView.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class PhoneNumberInputView: UIView {
    
    // MARK: Properties
    let numberPad = WindoNumberPad()
    
    let welcomeLabel = UILabel()
    let numberInputLabel = PhoneNumberInputLabel()
    
    let codeExplanationLabel = UILabel()
    let codeInputLabel = CodeInputLabel()
    
    let nextButton = UIButton()
    let goBackButton = UIButton()
    
    let loadingView = WindoLoadingIcon()
    
    let nameInputView = NameInputView()
    
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Animations
    let hideDuration:Double = 1.25
    let hideOption = UIViewAnimationOptions.curveLinear
    let hideSpring:CGFloat = 1.0
    let shrink = CGAffineTransform(scaleX: 1.0, y: 1.0)
    let grow = CGAffineTransform(scaleX: 1.0, y: 1.0)
    let phoneMove = CGAffineTransform(translationX: -screenWidth/1.5, y: 0)
    let codeMove = CGAffineTransform(translationX: screenWidth/1.5, y: 0)
    let loadShrink = CGAffineTransform(scaleX: 0.75, y: 0.75)
    
    func hidePhoneInput() {
        UIView.animate(withDuration: hideDuration, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
                let concat = self.phoneMove.concatenating(self.shrink)
                self.numberInputLabel.transform = concat
                self.welcomeLabel.transform = concat
            
                self.numberInputLabel.alpha = 0.0
                self.welcomeLabel.alpha = 0.0
            }, completion: nil)
    }
    
    func showPhoneInput() {
        UIView.animate(withDuration: hideDuration, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            let move = CGAffineTransform(translationX: 0, y: 0)
            let concat = move.concatenating(self.grow)
            self.numberInputLabel.transform = concat
            self.welcomeLabel.transform = concat
            
            self.numberInputLabel.alpha = 1.0
            self.welcomeLabel.alpha = 1.0
            }, completion: nil)
    }
    
    func hideCodeInput() {
        UIView.animate(withDuration: hideDuration, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
                let concat = self.codeMove.concatenating(self.shrink)
                self.codeInputLabel.transform = concat
                self.codeExplanationLabel.transform = concat
            
                self.codeInputLabel.alpha = 0.0
                self.codeExplanationLabel.alpha = 0.0
            }, completion: nil)
    }
    
    func showCodeInput() {
        UIView.animate(withDuration: hideDuration, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            let move = CGAffineTransform(translationX: 0, y: 0)
            let concat = move.concatenating(self.grow)
            self.codeInputLabel.transform = concat
            self.codeExplanationLabel.transform = concat
            
            self.codeInputLabel.alpha = 1.0
            self.codeExplanationLabel.alpha = 1.0
            }, completion: nil)
    }
    
    func hideLoading() {
        UIView.animate(withDuration: hideDuration - 0.75, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            self.loadingView.transform = self.loadShrink
            self.loadingView.alpha = 0.0
            }, completion: nil)
    }
    
    func showLoading() {
        UIView.animate(withDuration: hideDuration - 0.25, delay: 0.25, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            self.loadingView.transform = self.grow
            self.loadingView.alpha = 1.0
            }, completion: nil)
    }
    
    func hideGoBack() {
        nextButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.cxcx.of(self),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth)
        )
        
        goBackButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.rl.of(nextButton),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth)
        )
        
        UIView.animate(withDuration: hideDuration / 2, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    func showGoBack() {
        nextButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.rr.of(self),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth/2 - 1)
        )
        
        goBackButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.ll.of(self),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth/2 - 1)
        )
        
        UIView.animate(withDuration: hideDuration / 2, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    func toggleNextButton(_ on: Bool) {
        var targetAlpha:CGFloat = 0.5
        if on {
            targetAlpha = 1.0
        }
        
        nextButton.isEnabled = on
        
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.alpha = targetAlpha
        }) 
    }
    
    func showNameInput() {
        nameInputView.addConstraints(
            Constraint.ttbb.of(self),
            Constraint.llrr.of(self)
        )
        
        UIView.animate(withDuration: hideDuration, delay: 0, usingSpringWithDamping: hideSpring, initialSpringVelocity: 0.0, options: hideOption, animations: {
            let slide = CGAffineTransform(translationX: -screenWidth, y: 0)
            self.numberPad.transform = slide
            self.codeInputLabel.transform = slide
            self.codeExplanationLabel.transform = slide
            self.layoutIfNeeded()
            }, completion: { finished in
                self.nameInputView.firstNameTextField.becomeFirstResponder()
        })
    }
    
    // MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightTeal()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        var attrString = NSMutableAttributedString(string: "Welcome to Windo.\nEnter your phone number to continue.")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        welcomeLabel.attributedText = attrString
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont.graphikRegular(20)
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        
        attrString = NSMutableAttributedString(string: "Great!\nWe sent you a code,\ncopy it here to enter Windo.")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        codeExplanationLabel.attributedText = attrString
        codeExplanationLabel.textColor = UIColor.white
        codeExplanationLabel.font = UIFont.graphikRegular(20)
        codeExplanationLabel.textAlignment = .center
        codeExplanationLabel.numberOfLines = 0
        
        codeExplanationLabel.transform = codeMove.concatenating(shrink)
        codeExplanationLabel.alpha = 0.0
        codeInputLabel.transform = codeMove.concatenating(shrink)
        codeInputLabel.alpha = 0.0
        
        nextButton.setTitle("NEXT", for: UIControlState())
        nextButton.setTitleColor(UIColor.lightTeal(), for: UIControlState())
        nextButton.setTitleColor(UIColor.darkTeal(), for: .highlighted)
        nextButton.titleLabel!.font = UIFont.graphikRegular(20)
        nextButton.backgroundColor = UIColor.white
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
        goBackButton.setTitle("GO BACK", for: UIControlState())
        goBackButton.setTitleColor(UIColor.lightTeal(), for: UIControlState())
        goBackButton.setTitleColor(UIColor.darkTeal(), for: .highlighted)
        goBackButton.titleLabel!.font = UIFont.graphikRegular(20)
        goBackButton.backgroundColor = UIColor.white
        
        loadingView.transform = loadShrink
        loadingView.alpha = 0.0
        
        addSubview(welcomeLabel)
        addSubview(numberPad)
        addSubview(numberInputLabel)
        addSubview(codeInputLabel)
        addSubview(nextButton)
        addSubview(goBackButton)
        addSubview(codeExplanationLabel)
        addSubview(loadingView)
        addSubview(nameInputView)
    }
    
    func applyConstraints(){
        welcomeLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth - 100)
        )
            
        numberPad.addConstraints(
            Constraint.llrr.of(self, offset: 10),
            Constraint.tb.of(numberInputLabel),
            Constraint.bt.of(nextButton, offset: -25)
        )
        
        numberInputLabel.addConstraints(
            Constraint.tb.of(welcomeLabel),
            Constraint.bt.of(numberPad, offset: -10),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.9)
        )
        
        nextButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.cxcx.of(self),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth)
        )
        
        goBackButton.addConstraints(
            Constraint.bb.of(self),
            Constraint.rl.of(nextButton),
            Constraint.h.of(50),
            Constraint.w.of(screenWidth/2 - 1)
        )
        
        codeExplanationLabel.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth - 100)
        )
        
        codeInputLabel.addConstraints(
            Constraint.cycy.of(numberInputLabel),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.43333)
        )
        
        loadingView.addConstraints(
            Constraint.tt.of(self, offset: screenHeight/8),
            Constraint.cxcx.of(self),
            Constraint.wh.of(100)
        )
        
        nameInputView.addConstraints(
            Constraint.ttbb.of(self),
            Constraint.lr.of(self),
            Constraint.w.of(screenWidth)
        )
    }
}

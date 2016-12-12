//
//  WindoAlertView.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum WindoButtonType {
    /// The button text will appear red! Be careful!
    case destructive
    case simple
    /// The button text will appear lighter
    case secondary
}

class WindoAlertView: UIView {
    
    //MARK: Properties
    var messageContainer = UIView()
    var messageLabel = UILabel()
    var actionStackView = UIStackView()
    
    var message = ""
    var alertColor = UIColor.white
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(color: UIColor, message: String) {
        self.init()
        alertColor = color
        self.message = message
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = UIColor.clear
        
        messageContainer.backgroundColor = UIColor.white
        messageContainer.layer.cornerRadius = 5.0
        
        messageLabel.text = message
        messageLabel.textColor = alertColor
        messageLabel.font = UIFont.graphikRegular(16)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        actionStackView.alignment = .center
        actionStackView.axis = .vertical
        actionStackView.distribution = .equalCentering
        actionStackView.spacing = 0
        
        addSubview(messageContainer)
        addSubview(actionStackView)
        addSubview(messageLabel)
    }
    
    func applyConstraints(){
        messageContainer.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.8),
            Constraint.h.of(screenHeight * 0.2)
        )
        
        messageLabel.addConstraints(
            Constraint.ttbb.of(messageContainer, offset: 15),
            Constraint.llrr.of(messageContainer, offset: 15)
        )
        
        actionStackView.addConstraints(
            Constraint.tb.of(messageContainer, offset: 12),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.8)
        )
    }
    
    func addAction(_ type: WindoButtonType, title: String, action: () -> Void) {
//        let newButton = UIButton()
//        
//        switch type {
//        case .simple:
//            newButton.setTitleColor(alertColor, for: UIControlState())
//        case .secondary:
//            newButton.setTitleColor(alertColor, for: UIControlState())
//            newButton.titleLabel!.alpha = 0.65
//        case .destructive:
//            newButton.setTitleColor(.red, for: UIControlState())
//        }
//        
//        newButton.setTitle(title, for: UIControlState())
//        newButton.addTarget(self, action: action, for: .touchDown)
////        newButton.addTarget(.touchUpInside, action: action)
//        newButton.backgroundColor = UIColor.white
//        
//        newButton.addConstraints(
//            Constraint.w.of(screenWidth * 0.8),
//            Constraint.h.of(60)
//        )
//        
//        actionStackView.addArrangedSubview(newButton)
    }
}

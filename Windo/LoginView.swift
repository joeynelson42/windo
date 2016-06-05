//
//  LoginView.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    //MARK: Properties
    var windoLabel = UILabel()
    
    var googleButton = GIDSignInButton()
    var facebookButton = GHButton()
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
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
        backgroundColor = UIColor.lightTeal()
        
        windoLabel.text = "windo"
        windoLabel.textColor = UIColor.whiteColor()
        windoLabel.font = UIFont.graphikRegular(35)
        
        googleButton.colorScheme = GIDSignInButtonColorScheme.Light
        googleButton.style = GIDSignInButtonStyle.Wide
        
        addSubview(windoLabel)
        addSubview(googleButton)
    }
    
    func applyConstraints(){
        windoLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tt.of(self, offset: screenHeight * 0.125)
        )
        
        googleButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self, offset:  25)
        )
    }
}

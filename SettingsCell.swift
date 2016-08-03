//
//  SettingsCell.swift
//  Windo
//
//  Created by Joey on 8/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SettingsCell: UIView {
    
    //MARK: Properties
    
    let titleButton = UIButton()
    let expandingSeparator = UIView()
    let gr = UITapGestureRecognizer()
    
    var colorTheme: ColorTheme!
    
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
        backgroundColor = colorTheme.baseColor
        
        addGestureRecognizer(gr)
        
        titleButton.titleLabel?.font = UIFont.graphikRegular(18)
        titleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleButton.setTitleColor(colorTheme.darkColor, forState: .Highlighted)
        
        expandingSeparator.backgroundColor = colorTheme.darkColor
        addSubview(titleButton)
        addSubview(expandingSeparator)
    }
    
    func applyConstraints(){
        titleButton.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self, offset: 30)
        )
        
        expandingSeparator.addConstraints(
            Constraint.bb.of(self),
            Constraint.ll.of(self, offset: 20),
            Constraint.h.of(1),
            Constraint.w.of(screenWidth - 20)
        )
    }
    
    // MARK: Utilities
    
}
//
//  SettingsCell.swift
//  Windo
//
//  Created by Joey on 8/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum SettingsCellState {
    case closed
    case expanded
}

class SettingsCell: UIView {
    
    //MARK: Properties
    
    let titleLabel = UILabel()
    let expandingSeparator = UIView()
    let tapContainer = UIView()
    let gr = UITapGestureRecognizer()
    
    var state = SettingsCellState.closed
    var colorTheme: ColorTheme!
    
    // View Constants
    let toggleOpenSpeed:Double = 0.35
    
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
        clipsToBounds = true
        
        tapContainer.addGestureRecognizer(gr)
        
        titleLabel.font = UIFont.graphikRegular(18)
        titleLabel.textColor = UIColor.whiteColor()
        
        expandingSeparator.backgroundColor = colorTheme.darkColor
        addSubview(titleLabel)
        addSubview(expandingSeparator)
        addSubview(tapContainer)
    }
    
    func applyConstraints(){
        titleLabel.addConstraints(
            Constraint.cyt.of(self, offset: 30),
            Constraint.ll.of(self, offset: 30)
        )
        
        expandingSeparator.addConstraints(
            Constraint.tcy.of(titleLabel, offset: 29),
            Constraint.ll.of(self, offset: 20),
            Constraint.h.of(1),
            Constraint.w.of(screenWidth - 20)
        )
        
        tapContainer.addConstraints(
            Constraint.tt.of(self),
            Constraint.llrr.of(self),
            Constraint.h.of(60)
        )
    }
    
    // MARK: Methods
    
    func toggleSeparatorWithHeight(height: CGFloat) {
        var titleColor = UIColor.mikeBlue(0.55)
        if height == 0 {
            titleColor = UIColor.whiteColor()
        }
        
        expandingSeparator.addConstraints(
            Constraint.tcy.of(titleLabel, offset: 29),
            Constraint.ll.of(self, offset: 20),
            Constraint.h.of(height + 1),
            Constraint.w.of(screenWidth - 20)
        )
        
        UIView.animateWithDuration(toggleOpenSpeed) {
            self.titleLabel.textColor = titleColor
            self.layoutIfNeeded()
        }
    }
    
    // MARK: Utilities
    
}
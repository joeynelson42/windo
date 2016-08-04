//
//  NotificationSettingsView.swift
//  Windo
//
//  Created by Joey on 8/3/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class NotificationSettingsView: UIView {
    
    //MARK: Properties
    let headerLabel = UILabel()
    
    let newEventsTitleLabel = UILabel()
    let newEventsCheckmark = JNCheckToggle()
    
    let newChatTitleLabel = UILabel()
    let newChatCheckmark = JNCheckToggle()
    
    let respondedTitleLabel = UILabel()
    let respondedCheckmark = JNCheckToggle()
    
    let infoChangedTitleLabel = UILabel()
    let infoChangedCheckmark = JNCheckToggle()
    
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
        headerLabel.text = "Receive notifications for:"
        headerLabel.textColor = colorTheme.lightColor
        headerLabel.font = UIFont.graphikRegular(16)
        
        
        let titleLabelFont = UIFont.graphikRegular(16)
        let titleLabelTextColor = UIColor.whiteColor()
        let titleLabelAlignment = NSTextAlignment.Center
        
        newEventsTitleLabel.text = "New events"
        newEventsTitleLabel.font = titleLabelFont
        newEventsTitleLabel.textColor = titleLabelTextColor
        newEventsTitleLabel.textAlignment = titleLabelAlignment
        
        newChatTitleLabel.text = "New chat messages"
        newChatTitleLabel.font = titleLabelFont
        newChatTitleLabel.textColor = titleLabelTextColor
        newChatTitleLabel.textAlignment = titleLabelAlignment
        
        respondedTitleLabel.text = "Everyone has responded"
        respondedTitleLabel.font = titleLabelFont
        respondedTitleLabel.textColor = titleLabelTextColor
        respondedTitleLabel.textAlignment = titleLabelAlignment
        
        infoChangedTitleLabel.text = "Event info changed"
        infoChangedTitleLabel.font = titleLabelFont
        infoChangedTitleLabel.textColor = titleLabelTextColor
        infoChangedTitleLabel.textAlignment = titleLabelAlignment
        
        let untoggledCheckColor = UIColor.clearColor()
        let toggledColor = UIColor.whiteColor()
        
        newEventsCheckmark.setUntoggledColor(untoggledCheckColor)
        newEventsCheckmark.setToggledColor(toggledColor)
        newEventsCheckmark.diameter = 25
        newEventsCheckmark.initialCornerRadius = 3
        
        newChatCheckmark.setUntoggledColor(untoggledCheckColor)
        newChatCheckmark.setToggledColor(toggledColor)
        newChatCheckmark.diameter = 25
        newChatCheckmark.initialCornerRadius = 3
        
        respondedCheckmark.setUntoggledColor(untoggledCheckColor)
        respondedCheckmark.setToggledColor(toggledColor)
        respondedCheckmark.diameter = 25
        respondedCheckmark.initialCornerRadius = 3
        
        infoChangedCheckmark.setUntoggledColor(untoggledCheckColor)
        infoChangedCheckmark.setToggledColor(toggledColor)
        infoChangedCheckmark.diameter = 25
        infoChangedCheckmark.initialCornerRadius = 3
        
        addSubview(headerLabel)
        
        addSubview(newEventsTitleLabel)
        addSubview(newChatTitleLabel)
        addSubview(respondedTitleLabel)
        addSubview(infoChangedTitleLabel)
        
        addSubview(newEventsCheckmark)
        addSubview(newChatCheckmark)
        addSubview(respondedCheckmark)
        addSubview(infoChangedCheckmark)
    }
    
    func applyConstraints(){
        headerLabel.addConstraints(
            Constraint.tt.of(self, offset: 11),
            Constraint.ll.of(self, offset: 13),
            Constraint.w.of(screenWidth)
        )
        
        newEventsTitleLabel.addConstraints(
            Constraint.tt.of(self, offset: 40),
            Constraint.llrr.of(self),
            Constraint.h.of(16)
        )
        
        newEventsCheckmark.addConstraints(
            Constraint.tb.of(newEventsTitleLabel, offset: -7.5),
            Constraint.cxcx.of(self),
            Constraint.wh.of(50)
        )
        
        newChatTitleLabel.addConstraints(
            Constraint.tb.of(newEventsTitleLabel, offset: 50),
            Constraint.llrr.of(self),
            Constraint.h.of(16)
        )
        
        newChatCheckmark.addConstraints(
            Constraint.tb.of(newChatTitleLabel, offset: -7.5),
            Constraint.cxcx.of(self),
            Constraint.wh.of(50)
        )
        
        respondedTitleLabel.addConstraints(
            Constraint.tb.of(newChatTitleLabel, offset: 50),
            Constraint.llrr.of(self),
            Constraint.h.of(16)
        )
        
        respondedCheckmark.addConstraints(
            Constraint.tb.of(respondedTitleLabel, offset: -7.5),
            Constraint.cxcx.of(self),
            Constraint.wh.of(50)
        )
        
        infoChangedTitleLabel.addConstraints(
            Constraint.tb.of(respondedTitleLabel, offset: 50),
            Constraint.llrr.of(self),
            Constraint.h.of(16)
        )
        
        infoChangedCheckmark.addConstraints(
            Constraint.tb.of(infoChangedTitleLabel, offset: -7.5),
            Constraint.cxcx.of(self),
            Constraint.wh.of(50)
        )
    }
    
    // MARK: Methods
    
    
    // MARK: Utilities
    
}
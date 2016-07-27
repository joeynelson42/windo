//
//  TimeCell.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum TimeCellState: Int {
    case selected = 0
    case unselected
    case hidden
    case unavailable
}

class TimeCell: UIView {
    
    //MARK: Properties
    var state = TimeCellState.unselected
    var colorTheme = ColorTheme(color: .blue)
    var time = NSDate()
    
    var selectedBackground = UIView()
    var timeButton = UIButton()
    
    //MARK: Inits
    private convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(state: TimeCellState, colorTheme: ColorTheme, time: NSDate){
        self.init(frame: CGRectZero)
        self.state = state
        self.colorTheme = colorTheme
        self.time = time
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func handleTap() {
        switch state {
        case .selected:
            state = .unselected
        case .unselected:
            state = .selected
        case .hidden:
            break
        case .unavailable:
            break
        }
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        selectedBackground.backgroundColor = colorTheme.darkColor
        
        timeButton.setTitle("\(time.hour()):\(time.minute())", forState: .Normal)
        timeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        timeButton.titleLabel?.font = UIFont.graphikRegular(20)
        
        switch state {
        case .selected:
            configureSelected()
        case .unselected:
            configureUnselected()
        case .hidden:
            configureHidden()
        case .unavailable:
            configureUnavailable()
        }
        
        addSubview(selectedBackground)
        addSubview(timeButton)
    }
    
    func configureSelected() {
        selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
        selectedBackground.alpha = 1.0
    }
    
    func configureUnselected() {
        selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        selectedBackground.alpha = 0.0
    }
    
    func configureHidden() {
        selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        selectedBackground.alpha = 0.0
    }
    
    func configureUnavailable() {
        backgroundColor = UIColor.lightGrayColor()
        selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        selectedBackground.alpha = 0.0
    }
    
    func applyConstraints() {
        selectedBackground.fillSuperview()
        timeButton.fillSuperview()
    }
}
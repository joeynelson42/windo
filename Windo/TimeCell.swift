//
//  TimeCell.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol TimeCellDelegate {
    func timeCellStateChanged(newState: TimeCellState, date: NSDate)
}

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
    var delegate: TimeCellDelegate!
    
    var selectedBackground = UIView()
    var timeButton = UIButton()
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
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
            handleDeselect()
            delegate.timeCellStateChanged(.unselected, date: time)
        case .unselected:
            handleSelect()
            delegate.timeCellStateChanged(.selected, date: time)
        case .hidden:
            break
        case .unavailable:
            break
        }
    }
    
    func handleSelect() {
        state = .selected
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
            self.timeButton.alpha = 1.0
            self.selectedBackground.alpha = 1.0
            self.selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
    }
    
    func handleDeselect() {
        state = .unselected
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
            self.timeButton.alpha = 0.75
            self.selectedBackground.alpha = 0.0
            self.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            }, completion: nil)
    }
    
    func unhide() {
        state = .unselected
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func applyConstraints() {
        selectedBackground.fillSuperview()
        timeButton.fillSuperview()
    }
    
    func configureSubviews() {
        selectedBackground.backgroundColor = colorTheme.darkColor
        backgroundColor = colorTheme.baseColor
        var hour = time.hour() % 12
        if hour == 0 {
            hour = 12
        }
        
        if time.minute() == 0 {
            timeButton.setTitle("\(hour)", forState: .Normal)
        } else {
            timeButton.setTitle("\(hour):\(time.minute())", forState: .Normal)
        }
        timeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        timeButton.titleLabel?.font = UIFont.graphikRegular(16)
        
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
        
        timeButton.alpha = 0.75
    }
    
    func configureHidden() {
        selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        selectedBackground.alpha = 0.0
        
        timeButton.alpha = 0.0
    }
    
    func configureUnavailable() {
        backgroundColor = UIColor.lightGrayColor()
        selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        selectedBackground.alpha = 0.0
    }
    
    func updateWithState(state: TimeCellState) {
        self.state = state
        switch state {
        case .selected:
            configureSelected()
        case .unselected:
            configureUnselected()
        case .unavailable:
            configureUnavailable()
        case .hidden:
            configureHidden()
        }
    }
}
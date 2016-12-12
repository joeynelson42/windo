 //
//  TimeView.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol TimeViewDelegate {
    @objc optional func updateSelectedTimes(_ time: Int)
}

enum TimeState{
    case unavailable
    case unselected
    case selected
}

class TimeView: UIView {
    
    //MARK: Properties
    var timeButton = UIButton()
    var selectedBackground = UIView()
    
    var delegate: TimeViewDelegate!
    var state = TimeState.unselected
    var time = 0
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(cellTime: Int, timeDelegate: TimeViewDelegate){
        self.init(frame: CGRect.zero)
        time = cellTime
        delegate = timeDelegate
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
        backgroundColor = UIColor.lightBlue()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimeView.handleTap))
        addGestureRecognizer(tap)
        
        timeButton.setTitleColor(UIColor.white, for: UIControlState())
        timeButton.titleLabel?.font = UIFont.graphikRegular(20)
        
        timeButton.addTarget(self, action: #selector(TimeView.handleTap), for: .touchUpInside)
        
        selectedBackground.backgroundColor = UIColor.darkBlue()
        
        updateState()
        
        addSubview(selectedBackground)
        addSubview(timeButton)
    }
    
    func applyConstraints(){
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(timeSelectSize)
        )
        
        timeButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(timeSelectSize)
        )
    }
    
    func handleTap(){
        if state == .unavailable{
            return
        }
        
        if selectedBackground.alpha == 0 {
            state = .selected
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { void in
                self.timeButton.alpha = 1.0
                self.selectedBackground.alpha = 1.0
                self.selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
        }
        else {
            state = .unselected
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { void in
                self.timeButton.alpha = 0.75
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion: nil)
        }
        
        delegate.updateSelectedTimes?(time)
    }
    
    func updateState(){
        switch state {
        case .unavailable:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.gray
            selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            timeButton.alpha = 0.25
        case .selected:
            selectedBackground.alpha = 1.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            timeButton.alpha = 1.0
        case .unselected:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            timeButton.alpha = 0.75
        }
    }
}





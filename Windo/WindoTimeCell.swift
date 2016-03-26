//
//  WindoTimeCell.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol WindoTimeCellDelegate {
    optional func updateSelectedTimes(time: Int)
}

class WindoTimeCell: UIView {
    
    //MARK: Properties
    var delegate: WindoTimeCellDelegate!
    var timeButton = UIButton()
    var selectedBackground = UIView()
    var timeSelected = false
    
    var date = NSDate()
    var time = 0
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(cellTime: Int, cellDelegate: WindoTimeCellDelegate){
        self.init(frame: CGRectZero)
        time = cellTime
        delegate = cellDelegate
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
        if time > 12 {
            timeButton.setTitle("\(time - 12)", forState: .Normal)
        }
        else {
            timeButton.setTitle("\(time)", forState: .Normal)
        }
        
        if timeSelected{ forceHighlight() }
        else { forceUnhighlight() }
        
        timeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        timeButton.titleLabel!.font = UIFont.graphikRegular(20)
        timeButton.addTarget(self, action: #selector(WindoTimeCell.handleTap), forControlEvents: .TouchUpInside)
        
        selectedBackground.backgroundColor = UIColor.darkBlue()
        let tap = UITapGestureRecognizer(target: self, action: #selector(WindoTimeCell.handleTap))
        selectedBackground.addGestureRecognizer(tap)
        
        addSubview(selectedBackground)
        addSubview(timeButton)
    }
    
    func applyConstraints(){
        timeButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(70)
        )
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(55)
        )
    }
    
    func handleTap(){
        delegate.updateSelectedTimes!(time)
        
        if selectedBackground.alpha == 0 {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                self.selectedBackground.alpha = 1.0
                self.selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
        }
        else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
                }, completion: nil)
        }
    }
    
    func forceHighlight(){
        self.selectedBackground.alpha = 1.0
        self.selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
    }
    
    func forceUnhighlight(){
        self.selectedBackground.alpha = 0.0
        self.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
    }
}
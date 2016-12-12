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
    @objc optional func updateSelectedTimes(_ time: Int)
    @objc optional func isTimeSelected(_ time: Int) -> Bool
}

class WindoTimeCell: UIView {
    
    //MARK: Properties
    var delegate: WindoTimeCellDelegate!
    var timeButton = UIButton()
    var selectedBackground = UIView()
    
    var date = Date()
    var time = 0
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(cellTime: Int, cellDelegate: WindoTimeCellDelegate, cellDate: Date){
        self.init(frame: CGRect.zero)
        time = cellTime
        delegate = cellDelegate
        date = cellDate
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
            timeButton.setTitle("\(time - 12)", for: UIControlState())
        }
        else {
            timeButton.setTitle("\(time)", for: UIControlState())
        }
        
        selectedBackground.alpha = 0.0
        selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        
        timeButton.setTitleColor(UIColor.white, for: UIControlState())
        timeButton.titleLabel!.font = UIFont.graphikRegular(20)
        timeButton.addTarget(self, action: #selector(WindoTimeCell.handleTap), for: .touchUpInside)
        
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
        
        if delegate.isTimeSelected!(time) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { void in
                self.selectedBackground.alpha = 1.0
                self.selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: {void in
                    self.forceHighlight()
            })
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: {
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion: {void in
                    self.forceUnhighlight()
            })
        }
    }
    
    func forceHighlight(){
        selectedBackground.alpha = 1.0
        selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
    
    func forceUnhighlight(){
        selectedBackground.alpha = 0.0
        selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
}

//
//  CalendarDayView.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class CalendarDayView: UIView {
    
    //MARK: Properties
    var selectedBackground = UIView()
    var dateButton = UIButton()
    
    var day: Int!
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(dayNumber: Int){
        self.init(frame: CGRectZero)
        day = dayNumber
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
        selectedBackground.alpha = 0
        selectedBackground.backgroundColor = UIColor.darkBlue()
        
        dateButton.setTitle("\(day)", forState: .Normal)
        dateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        dateButton.titleLabel?.font = UIFont.graphikRegular(18)
        
        dateButton.addTarget(self, action: #selector(CalendarDayView.tapped), forControlEvents: .TouchUpInside)
        
        addSubview(selectedBackground)
        addSubview(dateButton)
    }
    
    func tapped(){
        if selectedBackground.alpha == 0 {
            UIView.animateWithDuration(0.5, animations: { void in
                self.selectedBackground.alpha = 1.0
            })
        }
        else {
            UIView.animateWithDuration(0.5, animations: { void in
                self.selectedBackground.alpha = 0
            })
        }
        
        
    }
    
    func applyConstraints(){
        let daySize: CGFloat = (screenWidth - 8)/7
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
        
        dateButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
    }
}
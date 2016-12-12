//
//  CalendarCell.swift
//  Windo
//
//  Created by Joey on 12/12/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum SelectionType : Int {
    case none
    case selected
}

class CalendarCell: FSCalendarCell {
    
    //MARK: Properties
    let defaultBackground = UIView()
    let selectedBackground = UIView()
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        updateWithSelectedState()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        self.shapeLayer.isHidden = true
        backgroundColor = .blue()
        clipsToBounds = true
        
        defaultBackground.backgroundColor = .lightBlue()
        
        selectedBackground.backgroundColor = .darkBlue()
        selectedBackground.layer.borderWidth = 0.5
        selectedBackground.layer.borderColor = UIColor.lightBlue().cgColor
        selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        
        addSubview(defaultBackground)
        addSubview(selectedBackground)
        sendSubview(toBack: selectedBackground)
        sendSubview(toBack: defaultBackground)
    }
    
    func applyConstraints(){
        
        defaultBackground.addConstraints(
            Constraint.cxcx.of(titleLabel),
            Constraint.cycy.of(titleLabel),
            Constraint.wh.of(50)
        )
        
        selectedBackground.addConstraints(
            Constraint.llrr.of(defaultBackground),
            Constraint.ttbb.of(defaultBackground)
        )
    }
    
    func updateWithSelectedState(animated: Bool = false) {
        
        if isSelected {
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                    self.selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
            } else {
                self.selectedBackground.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            
        } else {
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                    self.selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion: nil)
            } else {
                self.selectedBackground.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }
        }
    }
}

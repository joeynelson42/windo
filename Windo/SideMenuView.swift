//
//  SideMenuView.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SideMenuView: UIView {
    
    //MARK: Properties
    var tutorialButton = GHButton()
    
    var nameLabel = UILabel()
    
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
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        tutorialButton.setTitle("tutorial", forState: .Normal)
        tutorialButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        tutorialButton.backgroundColor = UIColor.lightTeal()
        tutorialButton.layer.cornerRadius = 5.0
        
        addSubview(tutorialButton)
    }
    
    func applyConstraints(){
        tutorialButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(125),
            Constraint.h.of(50)
        )
    }
}
//
//  InputCharacter.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InputCharacter : UIView {
    
    // MARK: Properties
    let character = UILabel()
    let fadedUnderline = UIView()
    let loadedUnderline = UIView()
    
    internal var characterSize: CGFloat = 18
    
    // MARK: Inits
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
    
    // MARK: Methods
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        character.textAlignment = .Center
        character.font = UIFont.graphikMedium(30)
        character.textColor = UIColor.whiteColor()
        
        
        addSubview(character)
        addSubview(fadedUnderline)
    }
    
    func applyConstraints() {
        character.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(characterSize),
            Constraint.h.of(characterSize)
        )
        
        fadedUnderline.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tb.of(character, offset: 3),
            Constraint.w.of(characterSize),
            Constraint.h.of(characterSize)
        )
    }
}
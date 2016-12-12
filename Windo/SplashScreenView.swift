//
//  SplashScreenView.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class SplashScreenView: UIView {
    
    //MARK: Properties
    var windoLabel = UILabel()
    var color: UIColor?
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(color: UIColor) {
        self.init()
        self.color = color
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
        backgroundColor = color
        
        windoLabel.text = "windo"
        windoLabel.textColor = UIColor.white
        windoLabel.font = UIFont.systemFont(ofSize: 35)
        windoLabel.textAlignment = .center
        
        addSubview(windoLabel)
    }
    
    func applyConstraints(){
        windoLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(100)
        )
    }
}

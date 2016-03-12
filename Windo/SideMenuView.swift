//
//  SideMenuView.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SideMenuView: UIView {
    
    
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
        configureSubviews()
        
        
        super.updateConstraints()
    }
    
    func configureSubviews(){

    }
}
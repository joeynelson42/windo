//
//  HomeView.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    //MARK: Properties
    
    
    //MARK: View Configuration
    
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
        
    }
    
    func applyConstraints(){
//        windo.constrainUsing(constraints: [
//            .cxcx : (of: self, offset: 0),
//            .cycy : (of: self, offset: 0),
//            .w : (of: nil, offset: screenWidth),
//            .h : (of: nil, offset: screenHeight)])
    }
}

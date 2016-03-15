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
    var eventTableView = UITableView()
    var lowerBackgroundView = UIView()
    
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
        backgroundColor = UIColor.lightTeal()
        
        eventTableView.backgroundColor = UIColor.clearColor()
        eventTableView.showsVerticalScrollIndicator = false
        eventTableView.separatorColor = UIColor.mikeBlue(0.34)
        eventTableView.registerClass(EventCell.self, forCellReuseIdentifier: "eventCell")
        eventTableView.registerClass(EventHeaderCell.self, forHeaderFooterViewReuseIdentifier: "eventHeaderCell")
        
        lowerBackgroundView.backgroundColor = UIColor.darkTeal()
        
        addSubview(lowerBackgroundView)
        addSubview(eventTableView)
    }
    
    func applyConstraints(){
        lowerBackgroundView.constrainUsing(constraints: [
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.bb : (of: self, offset: 0),
            Constraint.Width : (of: nil, offset: screenWidth),
            Constraint.Height : (of: nil, offset: screenHeight/2)])
        
        eventTableView.constrainUsing(constraints: [
            Constraint.CenterXToCenterX : (of: self, offset: 0),
            Constraint.TopToTop : (of: self, offset: 64),
            Constraint.Width : (of: nil, offset: screenWidth),
            Constraint.Height : (of: nil, offset: screenHeight - 64)])
    }
}

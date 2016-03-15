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
        eventTableView.backgroundColor = UIColor.teal()
        eventTableView.showsVerticalScrollIndicator = false
        eventTableView.separatorColor = UIColor.mikeBlue(0.34)
        eventTableView.registerClass(EventCell.self, forCellReuseIdentifier: "eventCell")
        eventTableView.registerClass(EventHeaderCell.self, forHeaderFooterViewReuseIdentifier: "eventHeaderCell")
        
        addSubview(eventTableView)
    }
    
    func applyConstraints(){
        eventTableView.constrainUsing(constraints: [
            Constraint.CenterXToCenterX : (of: self, offset: 0),
            Constraint.TopToTop : (of: self, offset: 0),
            Constraint.Width : (of: nil, offset: screenWidth),
            Constraint.Height : (of: nil, offset: screenHeight)])
    }
}

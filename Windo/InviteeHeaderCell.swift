//
//  InviteeHeaderCell.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteeHeaderCell: UITableViewHeaderFooterView {
    
    //MARK: Properties
    var titleLabel = UILabel()
    
    //MARK: Inits
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.graphikRegular(12)
        addSubview(titleLabel)
    }
    
    func applyConstraints(){
        titleLabel.constrainUsing(constraints: [
            .ll : (of: self, offset: 20),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: screenWidth),
            .h : (of: nil, offset: 12)])
    }
}
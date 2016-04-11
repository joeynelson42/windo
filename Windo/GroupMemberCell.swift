//
//  GroupMemberCell.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {
    
    //MARK: Properties
    var nameLabel = UILabel()
    var initialsIcon = UIView()
    var initialsLabel = UILabel()
    var infoButton = UIButton()
    
    //MARK: Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.purple()
        
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.graphikRegular(16)
        
        infoButton.setImage(UIImage(named: "InfoButton"), forState: .Normal)
        
        initialsIcon.layer.borderWidth = 1.2
        initialsIcon.layer.borderColor = UIColor.whiteColor().CGColor
        initialsIcon.layer.cornerRadius = 22
        
        initialsLabel.textColor = UIColor.whiteColor()
        initialsLabel.textAlignment = .Center
        initialsLabel.font = UIFont.graphikRegular(19)
        
        addSubview(nameLabel)
        addSubview(initialsIcon)
        addSubview(initialsLabel)
        addSubview(infoButton)
    }
    
    func applyConstraints(){
        initialsIcon.constrainUsing(constraints: [
            .ll : (of: self, offset: 24),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: 44),
            .h : (of: nil, offset: 44)])
        
        initialsLabel.constrainUsing(constraints: [
            .cxcx : (of: initialsIcon, offset: 0),
            .cycy : (of: initialsIcon, offset: 0),
            .w : (of: nil, offset: 44),
            .h : (of: nil, offset: 44)])
        
        nameLabel.constrainUsing(constraints: [
            .lr : (of: initialsIcon, offset: 17),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: 200),
            .h : (of: nil, offset: 16)])
        
        infoButton.constrainUsing(constraints: [
            .rr : (of: self, offset: -27),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: 23),
            .h : (of: nil, offset: 23)])
    }
}
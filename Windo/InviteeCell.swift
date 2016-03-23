//
//  InviteeCell.swift
//  Windo
//
//  Created by Joey on 3/15/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteeCell: UITableViewCell {
    
    //MARK: Properties
    var nameLabel = UILabel()
    var userHandleLabel = UILabel()
    var initialsIcon = UIView()
    var initialsLabel = UILabel()
    var checkmarkImageView = UIImageView()
    
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
        backgroundColor = UIColor.whiteColor()
        
        nameLabel.textColor = UIColor.blue()
        nameLabel.font = UIFont.graphikRegular(16)
        
        userHandleLabel.textColor = UIColor.blue()
        userHandleLabel.font = UIFont.graphikRegular(14)
        userHandleLabel.alpha = 0.8
        
        checkmarkImageView.image = UIImage(named: "checkmarkIcon")
        
        initialsIcon.layer.borderWidth = 1.2
        initialsIcon.layer.borderColor = UIColor.blue().CGColor
        initialsIcon.layer.cornerRadius = 22
        
        initialsLabel.textColor = UIColor.blue()
        initialsLabel.textAlignment = .Center
        initialsLabel.font = UIFont.graphikRegular(19)
        
        addSubview(nameLabel)
        addSubview(userHandleLabel)
        addSubview(initialsIcon)
        addSubview(initialsLabel)
        addSubview(checkmarkImageView)
    }
    
    func applyConstraints(){
        initialsIcon.addConstraints(
            Constraint.ll.of(self, offset: 24),
            Constraint.cycy.of(self),
            Constraint.wh.of(44)
        )
        
        initialsLabel.addConstraints(
            Constraint.cxcx.of(initialsIcon),
            Constraint.cycy.of(initialsIcon),
            Constraint.wh.of(44)
        )
        
        nameLabel.addConstraints(
            Constraint.lr.of(initialsIcon, offset: 17),
            Constraint.cycy.of(self, offset: -9),
            Constraint.w.of(200),
            Constraint.h.of(16)
        )
        
        userHandleLabel.addConstraints(
            Constraint.ll.of(nameLabel),
            Constraint.tb.of(nameLabel, offset: 3),
            Constraint.w.of(200),
            Constraint.h.of(14)
        )
    }
}
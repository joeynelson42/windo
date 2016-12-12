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
    var subtitleLabel = UILabel()
    
    var initials = UserInitialsView()
    
    var checkmarkImageView = UIImageView()
    var infoButton = UIButton()
    var infoGestureContainer = UIView()
    var infoGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Configuration
    
    override func prepareForReuse() {
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.white
        
        nameLabel.textColor = UIColor.blue()
        nameLabel.font = UIFont.graphikRegular(16)
        
        subtitleLabel.textColor = UIColor.blue()
        subtitleLabel.font = UIFont.graphikRegular(14)
        subtitleLabel.alpha = 0.8
        
        checkmarkImageView.image = UIImage(named: "checkmarkIcon")
        checkmarkImageView.contentMode = .scaleAspectFit
        
        infoButton.setImage(UIImage(named: "BlueInfoIcon"), for: UIControlState())
        
        initials.cornerRadius = 22
        initials.borderColor = UIColor.blue().cgColor
        initials.borderWidth = 1
        initials.initials.textColor = UIColor.blue()
        initials.fontSize = 22
        
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(initials)
        addSubview(checkmarkImageView)
        addSubview(infoButton)
        addSubview(infoGestureContainer)
        infoGestureContainer.addGestureRecognizer(infoGestureRecognizer)
    }
    
    func applyConstraints(){
        initials.addConstraints(
            Constraint.ll.of(self, offset: 24),
            Constraint.cycy.of(self),
            Constraint.wh.of(44)
        )
        
        nameLabel.addConstraints(
            Constraint.lr.of(initials, offset: 17),
            Constraint.cycy.of(self, offset: -9),
            Constraint.w.of(200),
            Constraint.h.of(16)
        )
        
        subtitleLabel.addConstraints(
            Constraint.ll.of(nameLabel),
            Constraint.tb.of(nameLabel, offset: 3),
            Constraint.w.of(200),
            Constraint.h.of(14)
        )
        
        checkmarkImageView.addConstraints(
            Constraint.rr.of(self, offset: -24),
            Constraint.cycy.of(self),
            Constraint.wh.of(24)
        )
        
        infoButton.addConstraints(
            Constraint.cxcx.of(checkmarkImageView),
            Constraint.cycy.of(checkmarkImageView)
        )
        
        infoGestureContainer.addConstraints(
            Constraint.tt.of(self),
            Constraint.rr.of(self),
            Constraint.w.of(48),
            Constraint.h.of(65)
        )
    }
    
    func animateChange() {
        let spring:CGFloat = 0.5
        let velocity:CGFloat = 0.1
        
        if checkmarkImageView.alpha == 0.0 {
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: spring, initialSpringVelocity: velocity, options: .curveEaseIn, animations: { Void in
                self.infoButton.alpha = 0.0
                self.infoButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion: nil)
            
            UIView.animate(withDuration: 0.25, delay: 0.1, usingSpringWithDamping: spring, initialSpringVelocity: velocity, options: .curveEaseOut, animations: {
                self.checkmarkImageView.alpha = 1.0
                self.checkmarkImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: {void in
                    self.infoGestureRecognizer.isEnabled = false
            })
            
        } else {
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: spring, initialSpringVelocity: velocity, options: .curveEaseIn, animations: { Void in
                self.checkmarkImageView.alpha = 0.0
                self.checkmarkImageView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }, completion:nil)
            
            UIView.animate(withDuration: 0.25, delay: 0.1, usingSpringWithDamping: spring, initialSpringVelocity: velocity, options: .curveEaseOut, animations: {
                self.infoButton.alpha = 1.0
                self.infoButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: {void in
                    self.infoGestureRecognizer.isEnabled = true
            })
        }
    }
}

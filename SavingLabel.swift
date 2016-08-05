//
//  SavingLabel.swift
//  Windo
//
//  Created by Joey on 8/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SavingLabel: UIView {
    
    //MARK: Properties
    var savingOrb = UIView()
    var mainLabel = UILabel()
    
    var colorTheme: ColorTheme!
    
    //MARK: Inits
    
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
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        mainLabel.alpha = 0.0
        mainLabel.text = "Saving..."
        mainLabel.textColor = colorTheme.lightColor
        mainLabel.font = UIFont.graphikLight(14)
        
        savingOrb.alpha = 0.0
        savingOrb.backgroundColor = UIColor.clearColor()
        savingOrb.layer.cornerRadius = 4
        savingOrb.layer.borderColor = colorTheme.lightColor.CGColor
        savingOrb.layer.borderWidth = 1.0
        
        addSubview(mainLabel)
        addSubview(savingOrb)
    }
    
    func applyConstraints(){
        mainLabel.addConstraints(
            Constraint.lr.of(savingOrb, offset: 4),
            Constraint.rr.of(self),
            Constraint.cycy.of(self),
            Constraint.h.of(15)
        )
        
        savingOrb.addConstraints(
            Constraint.ll.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(8)
        )
    }
    
    // MARK: Animation
    
    func start() {
        if savingOrb.alpha == 0.0 {
            UIView.animateWithDuration(0.5, animations: {
                self.savingOrb.alpha = 1.0
                self.mainLabel.alpha = 1.0
            }) { (finished) in
                UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: [.Autoreverse, .Repeat, .CurveLinear], animations: {
                    self.savingOrb.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    }, completion: nil)
            }
        } else {
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: [.Autoreverse, .Repeat, .CurveLinear], animations: {
                self.savingOrb.transform = CGAffineTransformMakeScale(0.8, 0.8)
                }, completion: nil)
        }
    }
    
    func finish() {
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: {
            self.mainLabel.text = "Saved!"
            self.savingOrb.backgroundColor = self.colorTheme.lightColor
            self.savingOrb.transform = CGAffineTransformIdentity
            }) { (finished) in
                UIView.animateWithDuration(0.5, animations: { 
                    self.savingOrb.alpha = 0.0
                    self.mainLabel.alpha = 0.0
                    }, completion: { void in
                        self.mainLabel.text = "Saving..."
                        self.savingOrb.backgroundColor = UIColor.clearColor()
                    })
        }
    }
}

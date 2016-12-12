//
//  WindoNumber.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoNumber: UIButton {
    
    //MARK: Properties
    let highlightedBorderColor = UIColor.white.cgColor
    let fadedBorderColor = UIColor.fromHex(0xFFFFF, alpha: 0.75).cgColor
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
        configureSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.clear
        layer.borderColor = fadedBorderColor
        layer.borderWidth = 1.0
        
        setTitleColor(UIColor.white, for: UIControlState())
        titleLabel!.font = UIFont.graphikRegular(25)
    }
    
    internal var minimumScale: CGFloat = 1.1
    internal var pressSpringDamping: CGFloat = 0.55
    internal var releaseSpringDamping: CGFloat = 0.65
    internal var pressSpringDuration = 0.35
    internal var releaseSpringDuration = 0.45
    
    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: self.minimumScale, y: self.minimumScale)
            self.layer.borderColor = self.highlightedBorderColor
            }, completion: nil)
    }
    
    override internal func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
            self.layer.borderColor = self.fadedBorderColor
            }, completion: nil)
    }
    
    override internal func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if !self.bounds.contains(location) {
            UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
                self.transform = CGAffineTransform.identity
                self.layer.borderColor = self.fadedBorderColor
                }, completion: nil)
        }
    }
    
    override internal func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
            self.layer.borderColor = self.fadedBorderColor
            }, completion: nil)
    }
}


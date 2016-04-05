//
//  ConnectingCirclesView.swift
//  Windo
//
//  Created by Joey on 4/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ConnectingCirclesView: UIView {
    
    //MARK: Properties
    var indicatorCircle = UIView()
    var circle1 = UIView()
    var circle2 = UIView()
    var circle3 = UIView()
    
    var connector1 = UIView()
    var connector2 = UIView()
    
    //MARK: View Configuration
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){        
        indicatorCircle.layer.cornerRadius = 5.0
        indicatorCircle.backgroundColor = UIColor.whiteColor()
        
        let color = UIColor.whiteColor()
        let alpha:CGFloat = 0.8
        
        circle1.layer.cornerRadius = 5.0
        circle1.backgroundColor = color
        circle1.alpha = alpha
        
        circle2.layer.cornerRadius = 5.0
        circle2.backgroundColor = color
        circle2.alpha = alpha
        
        circle3.layer.cornerRadius = 5.0
        circle3.backgroundColor = color
        circle3.alpha = alpha
        
        connector1.backgroundColor = color
        connector1.layer.cornerRadius = 5.0
        connector1.transform = CGAffineTransformMakeScale(1.0, 0.00001)
        connector1.alpha = alpha
        
        connector2.backgroundColor = color
        connector2.layer.cornerRadius = 5.0
        connector2.transform = CGAffineTransformMakeScale(1.0, 0.00001)
        connector2.alpha = alpha
        
        addSubviews(connector1, connector2)
        addSubviews(circle1, circle2, circle3)
        addSubview(indicatorCircle)
    }
    
    func applyConstraints(){
        indicatorCircle.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.wh.of(10)
        )
        
        circle1.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.wh.of(10)
        )
        
        circle2.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(self),
            Constraint.wh.of(10)
        )
        
        circle3.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self),
            Constraint.wh.of(10)
        )
        
        connector1.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.w.of(30),
            Constraint.h.of(10)
        )
        
        connector2.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self),
            Constraint.w.of(30),
            Constraint.h.of(10)
        )
    }
    
    func hideConnectors(){
        UIView.animateWithDuration(0.2, animations: {
            self.connector1.transform = CGAffineTransformMakeScale(1.0, 0.000001)
            self.connector2.transform = CGAffineTransformMakeScale(1.0, 0.000001)
        })
    }
    
    func showFirstConnector(){
        UIView.animateWithDuration(0.2, animations: {
            self.connector1.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    func showSecondConnector(){
        UIView.animateWithDuration(0.2, animations: {
            self.connector2.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
//    func leftToCenter(){
//        circle1.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.ll.of(self),
//            Constraint.h.of(10),
//            Constraint.w.of(30)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    func centerToRight(){
//        circle2.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.LeftToCenterX.of(self, offset: -5),
//            Constraint.h.of(10),
//            Constraint.w.of(30)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    func rightToCenter(){
//        
//    }
//    
//    func centerToLeft(){
//        
//    }
//    
//    func reset(){
//        circle1.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.ll.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        circle2.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.cxcx.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        circle3.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.rr.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
}





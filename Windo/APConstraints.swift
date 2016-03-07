//
//  APConstraints.swift
//  Copyright (c) 2015 Appsidian. All rights reserved.
//

/* 
    IMPORTANT NOTE:

Highlight the following code snippets and drag them into the Code Snippets area of Xcode (separately):


 - Completion Shortcut: constrain
 - Completion Scope: All

constrainUsing(constraints: [
    Constraint.<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>)])

(To be less verbose, you can use this block which removes repetition of "Constraint" but also removes code completion)
constrainUsing(constraints: [
    .<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, offset: <#CGFloat#>)])


 - Completion Shortcut: constrainMult
 - Completion Scope: All

constrainUsing(constraints: [
    Constraint.<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    Constraint.<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>)])

(To be less verbose, you can use this block which removes repetition of "Constraint" but also removes code completion)
constrainUsing(constraints: [
    .<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>),
    .<#constraint#> : (of: <#AnyObject?#>, multiplier: <#CGFloat#>, offset: <#CGFloat#>)])


Usage:

view.constrainUsing(constraints: [
    Constraint.llrr : (of: self, offset: 10),
    Constraint.tt   : (of: self, offset: 10),
    Constraint.h    : (of: nil, offset: 40)])

view.constrainUsing(constraints: [
    Constraint.ttbb : (of: someOtherView, multiplier: 1.0, offset: 0),
    Constraint.cxcx : (of: someOtherView, multiplier: 1.0, offset: 0),
    Constraint.w    : (of: someOtherView, multiplier: 0.8, offset: 0)])
                                                      ^ view will be 80% the width of someOtherView

*/

import UIKit

public enum Constraint {
    case LeftToLeftRightToRight
    case LeftToLeft
    case LeftToRight
    case LeftToCenterX
    case RightToRight
    case RightToLeft
    case RightToCenterX
    case TopToTopBottomToBottom
    case TopToTop
    case TopToBottom
    case TopToCenterY
    case BottomToBottom
    case BottomToTop
    case BottomToCenterY
    case CenterXToCenterX
    case CenterXToLeft
    case CenterXToRight
    case CenterYToCenterY
    case CenterYToTop
    case CenterYToBottom
    case Width
    case IntrinsicContentWidth
    case Height
    case IntrinsicContentHeight
    case WidthHeight
    case HeightWidth
    case Baseline
    case Default
    
    public static let llrr = Constraint.LeftToLeftRightToRight
    public static let ll   = Constraint.LeftToLeft
    public static let lr   = Constraint.LeftToRight
    public static let lcx  = Constraint.LeftToCenterX
    public static let rr   = Constraint.RightToRight
    public static let rl   = Constraint.RightToLeft
    public static let rcx  = Constraint.RightToCenterX
    public static let ttbb = Constraint.TopToTopBottomToBottom
    public static let tt   = Constraint.TopToTop
    public static let tb   = Constraint.TopToBottom
    public static let tcy  = Constraint.TopToCenterY
    public static let bb   = Constraint.BottomToBottom
    public static let bt   = Constraint.BottomToTop
    public static let bcy  = Constraint.BottomToCenterY
    public static let cxcx = Constraint.CenterXToCenterX
    public static let cxl  = Constraint.CenterXToLeft
    public static let cxr  = Constraint.CenterXToRight
    public static let cycy = Constraint.CenterYToCenterY
    public static let cyt  = Constraint.CenterYToTop
    public static let cyb  = Constraint.CenterYToBottom
    public static let w    = Constraint.Width
    public static let iw   = Constraint.IntrinsicContentWidth
    public static let h    = Constraint.Height
    public static let ih   = Constraint.IntrinsicContentHeight
    public static let wh   = Constraint.WidthHeight
    public static let hw   = Constraint.HeightWidth
    public static let bsln = Constraint.Baseline
    
    init() {
        self = .Default
    }
    
}

public extension UIView {
    
    /// Adds multiple subviews to the receiver, in the order specified in the array
    public func addSubviews(subviews: [UIView]) {
        for view in subviews {
            self.addSubview(view)
        }
    }
    
    /// Applies an array of NSLayoutConstraints to the view, using a multiplier and an offset
    public func constrainUsing(constraints constraints: [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)]) {
        var parent = self.superview!
        
        // Checks if constraining within a TableView/CollectionView cell
        if let superclass: AnyClass? = self.superview?.superview?.superclass {
            if superclass === UICollectionViewCell.self || superclass === UITableViewCell.self {
                parent = self.superview!.superview!
            }
        }
        
        // Remove all existing Constraints
        self.removeAllConstraints()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        for constraint in constraints {
            switch constraint.0 {
            case .LeftToLeftRightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .LeftToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToTopBottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .TopToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Width:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize().width + constraint.1.offset))
            case .Height:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize().height + constraint.1.offset))
            case .WidthHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .HeightWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Baseline:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Baseline, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Baseline, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Default:
                break
            }
        }
    }
    
    public func constrainUsing(constraints constraints: [Constraint: (of: AnyObject?, offset: CGFloat)]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1.of, CGFloat(1), constraint.1.offset)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    public func constrainUsing(constraints constraints: [Constraint : AnyObject?]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1, 1.0, 0)
        }
        constrainUsing(constraints: constraintDictionary)
    }

    
    // MARK: - Updating Constraints
    // -------------------------------------------------------------------------------
    
    public func updateConstraint(constraint constraint: Constraint, offset: CGFloat) {
        var firstAttribute: NSLayoutAttribute?
        var secondAttribute: NSLayoutAttribute?
        
        // Alternates will be set if the Constraint is a mix of two Constraints, e.g. .llrr
        var alternateFirstAttribute: NSLayoutAttribute?
        var alternateSecondAttribute: NSLayoutAttribute?
        
        switch constraint {
        case .LeftToLeftRightToRight:
            firstAttribute = .Left; secondAttribute = .Left
            alternateFirstAttribute = .Right; alternateSecondAttribute = .Right
        case .LeftToLeft:
            firstAttribute = .Left; secondAttribute = .Left
        case .LeftToRight:
            firstAttribute = .Left; secondAttribute = .Right
        case .LeftToCenterX:
            firstAttribute = .Left; secondAttribute = .CenterX
        case .RightToRight:
            firstAttribute = .Right; secondAttribute = .Right
        case .RightToLeft:
            firstAttribute = .Right; secondAttribute = .Left
        case .RightToCenterX:
            firstAttribute = .Right; secondAttribute = .CenterX
        case .TopToTopBottomToBottom:
            firstAttribute = .Top; secondAttribute = .Top
            alternateFirstAttribute = .Bottom; alternateSecondAttribute = .Bottom
        case .TopToTop:
            firstAttribute = .Top; secondAttribute = .Top
        case .TopToBottom:
            firstAttribute = .Top; secondAttribute = .Bottom
        case .TopToCenterY:
            firstAttribute = .Top; secondAttribute = .CenterY
        case .BottomToBottom:
            firstAttribute = .Bottom; secondAttribute = .Bottom
        case .BottomToTop:
            firstAttribute = .Bottom; secondAttribute = .Top
        case .BottomToCenterY:
            firstAttribute = .Bottom; secondAttribute = .CenterY
        case .CenterXToCenterX:
            firstAttribute = .CenterX; secondAttribute = .CenterX
        case .CenterXToLeft:
            firstAttribute = .CenterX; secondAttribute = .Left
        case .CenterXToRight:
            firstAttribute = .CenterX; secondAttribute = .Right
        case .CenterYToCenterY:
            firstAttribute = .CenterY; secondAttribute = .CenterY
        case .CenterYToTop:
            firstAttribute = .CenterY; secondAttribute = .Top
        case .CenterYToBottom:
            firstAttribute = .CenterY; secondAttribute = .Bottom
        case .Width:
            firstAttribute = .Width; secondAttribute = .Width
        case .IntrinsicContentWidth:
            print("Updating constraint .iw is not yet supported")
            return
        case .Height:
            firstAttribute = .Height; secondAttribute = .Height
        case .WidthHeight:
            firstAttribute = .Width; secondAttribute = .Width
            alternateFirstAttribute = .Height; alternateSecondAttribute = .Height
        case .HeightWidth:
            firstAttribute = .Height; secondAttribute = .Height
            alternateFirstAttribute = .Width; alternateSecondAttribute = .Width
        case .IntrinsicContentHeight:
            print("Updating constraint .ih is not yet supported")
            return
        case .Baseline:
            firstAttribute = .Baseline; secondAttribute = .Baseline
        case .Default:
            break
        }
        for existingConstraint in self.constraints {
            if existingConstraint.firstAttribute == firstAttribute && existingConstraint.secondAttribute == secondAttribute {
                existingConstraint.constant = offset
            }
            
            if let alternateFirstAttribute = alternateFirstAttribute, let alternateSecondAttribute = alternateSecondAttribute {
                if existingConstraint.firstAttribute == alternateFirstAttribute && existingConstraint.secondAttribute == alternateSecondAttribute {
                    existingConstraint.constant = offset
                }
            }
        }
        self.setNeedsUpdateConstraints()
    }
    
    public func setNeedsUpdateConstraintsOnAllSubviews() {
        self.setNeedsUpdateConstraints()
        for subview in self.subviews {
            subview.setNeedsUpdateConstraintsOnAllSubviews()
        }
    }
    
    
    // MARK: - Removing Constraints
    // -------------------------------------------------------------------------------
    
    public func removeAllConstraints() {
        if let parent = self.superview {
            for constraint in parent.constraints as [NSLayoutConstraint] {
                if constraint.firstItem as? UIView == self {
                    parent.removeConstraint(constraint)
                }
            }
        }
    }
    

    // MARK: - Orientation Constraint Convenience Methods
    // -------------------------------------------------------------------------------
    
    /// Usage: self.landscapeConstraints { (Add Constraints) }
    /// Takes advantage of Swift's trailing closure syntax.
    /// The code you include in the closure will only be executed if the device is in
    /// one of the landscape orientations
    public func landscapeConstraints(constraints: () -> Void) {
        if UIDevice.currentDevice().orientation.isLandscape {
            constraints()
        }
    }
    
    /// Usage: self.portraitConstraints { (Add Constraints) }
    /// Takes advantage of Swift's trailing closure syntax.
    /// The code you include in the closure will only be executed if the device is in
    /// one of the portrait orientations
    public func portraitConstraints(constraints: () -> Void) {
        if UIDevice.currentDevice().orientation.isPortrait {
            constraints()
        }
    }

    
    // MARK: - Convenience Constraint Macros
    // -------------------------------------------------------------------------------
    
    public func fillSuperview() {
        constrainUsing(constraints: [
            .llrr : (of: self.superview, multiplier: 1.0, offset: 0),
            .ttbb : (of: self.superview, multiplier: 1.0, offset: 0)])
    }
    
    public func centerInSuperview() {
        constrainUsing(constraints: [
            .cxcx : (of: self.superview, multiplier: 1.0, offset: 0),
            .cycy : (of: self.superview, multiplier: 1.0, offset: 0)])
    }
    
}

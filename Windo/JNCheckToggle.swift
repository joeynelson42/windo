//
//  JNCheckToggle.swift
//  spinningCheckmark
//
//  Created by Joey Nelson on 7/1/16.
//  Copyright © 2016 Joey Nelson. All rights reserved.
//

protocol JNCheckToggleDelegate {
    
    /**
     Called when the state of the checkToggle changes.
     
     :param: state The new state of the checkToggle.
     */
    func checkStateChanged(_ state: CheckToggleState)
}

extension JNCheckToggleDelegate {
    func checkStateChanged(_ state: CheckToggleState) {
        print("hey! the checkToggle is now \(state)")
    }
}

enum CheckToggleState {
    case toggled
    case untoggled
}

enum CheckToggleStyle {
    case none
    case light
    case dark
}

struct AnimationValues {
    var cornerRadius: CGFloat!
    var color: UIColor!
    var rotation: Float!
    var borderWidth: CGFloat!
}

import UIKit

@IBDesignable class JNCheckToggle: UIView {
    
    // MARK: Properties
    fileprivate let containerView = UIButton()
    fileprivate let checkmark = UIImageView()
    fileprivate var tapGR = UITapGestureRecognizer()
    
    /// Alerted on state change
    internal var delegate: JNCheckToggleDelegate?
    
    /// The state of the checkToggle
    internal var state = CheckToggleState.untoggled
    
    /// The color of the checkmark
    internal var style = CheckToggleStyle.light {
        didSet {
            configureStyle()
        }
    }
    
    /// The duration of the toggle animation
    internal var duration = 0.4
    
    /// The untoggled cornerRadius
    internal var initialCornerRadius: CGFloat = 2.0
    
    /// The diameter of the checkToggle
    internal var diameter:CGFloat = 40
    
    ///Contains the values for the untoggled checkmark, configure with ::configureUntoggledValues
    fileprivate var fromValues = AnimationValues(cornerRadius: 0, color: UIColor.white, rotation: 0, borderWidth: 1.0)
    
    ///Contains the values for the toggled checkmark, configure with ::configureToggledValues
    fileprivate var toValues = AnimationValues(cornerRadius: 0, color: UIColor.white, rotation: 0, borderWidth: 0.0)
    
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(initialState: CheckToggleState, style: CheckToggleStyle = CheckToggleStyle.light) {
        self.init(frame: CGRect.zero)
        self.state = initialState
        self.style = style
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    func animateToggle() {
        switch state {
        case .untoggled:
            toggleOn()
            state = .toggled
        case .toggled:
            toggleOff()
            state = .untoggled
        }
    }
    
    /**
     Set the color of the untoggled checkToggle
     
     :param: color The untoggled color.

     */
    func setUntoggledColor(_ color: UIColor = UIColor.white) {
        fromValues = AnimationValues(cornerRadius: initialCornerRadius, color: color, rotation: Float(M_PI), borderWidth: 1.5)
        if state == .untoggled {
            configureWithAnimationValues(fromValues)
        }
    }
    
    /**
     Set the color of the toggled checkToggle
     
     :param: color The toggled color.
     
     */
    func setToggledColor(_ color: UIColor = UIColor.white) {
        toValues = AnimationValues(cornerRadius: diameter/2, color: color, rotation: 0, borderWidth: 0.0)
        if state == .toggled {
            configureWithAnimationValues(toValues)
        }
    }
    
    // MARK: Private Methods
    // MARK: Animations
    
    ///Toggles the checkmark
    fileprivate func toggleOn() {
        
        let containerAnimations = createContainerAnimation(fromValues, endValues: toValues)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            guard let _ = self.delegate else { return }
            self.delegate!.checkStateChanged(self.state)
        }
        containerView.layer.add(containerAnimations, forKey: "startContainerAnimations")
        containerView.layer.cornerRadius = self.toValues.cornerRadius
        containerView.backgroundColor = self.toValues.color
        containerView.layer.borderWidth = toValues.borderWidth
        CATransaction.commit()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.checkmark.alpha = 1.0
            self.checkmark.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }
    
    ///Untoggles the checkmark
    fileprivate func toggleOff() {
        
        let containerAnimations = createContainerAnimation(toValues, endValues: fromValues)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            guard let _ = self.delegate else { return }
            self.delegate!.checkStateChanged(self.state)
        }
        containerView.layer.add(containerAnimations, forKey: "startContainerAnimations")
        containerView.layer.cornerRadius = self.fromValues.cornerRadius
        containerView.backgroundColor = self.fromValues.color
        containerView.layer.borderWidth = fromValues.borderWidth

        CATransaction.commit()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.checkmark.alpha = 0.0
            self.checkmark.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }, completion: nil)
    }
    
    fileprivate func createContainerAnimation(_ startValues: AnimationValues, endValues: AnimationValues) -> CAAnimationGroup {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = startValues.rotation
        rotationAnimation.toValue = endValues.rotation
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath:"cornerRadius")
        cornerRadiusAnimation.fromValue = startValues.cornerRadius
        cornerRadiusAnimation.toValue = endValues.cornerRadius
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = startValues.color
        colorAnimation.toValue = endValues.color
        
        let borderWidth = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.fromValue = startValues.borderWidth
        borderWidth.toValue = endValues.borderWidth
        
        let animations:CAAnimationGroup = CAAnimationGroup()
        animations.animations = [rotationAnimation, cornerRadiusAnimation, colorAnimation, borderWidth]
        animations.duration = duration
        animations.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animations
    }
    
    // MARK: View Configuration
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    fileprivate func configureSubviews() {
        backgroundColor = .clear
        clipsToBounds = false
        
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1.5
        containerView.addTarget(self, action: #selector(JNCheckToggle.animateToggle), for: .touchUpInside)

        checkmark.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        configureStyle()
        
        checkmark.contentMode = .scaleAspectFit
        
        tapGR = UITapGestureRecognizer(target: self, action: #selector(JNCheckToggle.animateToggle))
        addGestureRecognizer(tapGR)
        
        addSubview(containerView)
        addSubview(checkmark)
    }
    
    fileprivate func applyConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        
        let containerCenterX = NSLayoutConstraint(item: containerView,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let containerCenterY = NSLayoutConstraint(item: containerView,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let containerCenterWidth = NSLayoutConstraint(item: containerView,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: diameter)
        
        let containerCenterHeight = NSLayoutConstraint(item: containerView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: diameter)
        
        
        let checkmarkCenterX = NSLayoutConstraint(item: checkmark,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let checkmarkCenterY = NSLayoutConstraint(item: checkmark,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let checkmarkCenterWidth = NSLayoutConstraint(item: checkmark,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: diameter * 0.7)
        
        let checkmarkCenterHeight = NSLayoutConstraint(item: checkmark,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: diameter * 0.7)
        
        containerCenterX.isActive = true
        containerCenterY.isActive = true
        containerCenterWidth.isActive = true
        containerCenterHeight.isActive = true
        
        checkmarkCenterX.isActive = true
        checkmarkCenterY.isActive = true
        checkmarkCenterWidth.isActive = true
        checkmarkCenterHeight.isActive = true
    }
    
    fileprivate func configureWithAnimationValues(_ values: AnimationValues) {
        containerView.backgroundColor = values.color
        containerView.layer.cornerRadius = values.cornerRadius
    }
    
    fileprivate func configureStyle() {

        checkmark.image = UIImage(named: "tealCheckmark")
//        switch style {
//        case .none:
//            checkmark.hidden = true
//        case .light:
//            checkmark.image = UIImage(named: "lightCheckmark")
//        case .dark:
//            checkmark.image = UIImage(named: "darkCheckmark")
//        }
    }
}

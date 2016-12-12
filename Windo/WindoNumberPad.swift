//
//  WindoNumberPad.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit


protocol WindoNumberPadDelegate {
    func numberTapped(_ number: Int)
}

class WindoNumberPad: UIView {
    
    //MARK: Properties
    var delegate: WindoNumberPadDelegate? = nil
    
    let container = UIStackView()
    let topRow = UIStackView()
    let midRow = UIStackView()
    let bottomRow = UIStackView()
    let zeroRow = UIStackView()
    
    let buttonSize:CGFloat = screenWidth * 0.1867
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRect.zero)
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
        let spacing:CGFloat = screenWidth * 0.039
        
        container.alignment = .center
        container.axis = .vertical
        container.distribution = .equalSpacing
        container.spacing = spacing
        
        topRow.alignment = .center
        topRow.axis = .horizontal
        topRow.distribution = .equalSpacing
        topRow.spacing = spacing
        
        midRow.alignment = .center
        midRow.axis = .horizontal
        midRow.distribution = .equalSpacing
        midRow.spacing = spacing
        
        bottomRow.alignment = .center
        bottomRow.axis = .horizontal
        bottomRow.distribution = .equalSpacing
        bottomRow.spacing = spacing
        
        zeroRow.alignment = .center
        zeroRow.axis = .horizontal
        zeroRow.distribution = .equalSpacing
        zeroRow.spacing = spacing
        
        for i in 1...3 {
            let newTop = constructButton(i)
            let newMid = constructButton(i + 3)
            let newBottom = constructButton(i + 6)
            
            topRow.addArrangedSubview(newTop)
            midRow.addArrangedSubview(newMid)
            bottomRow.addArrangedSubview(newBottom)
        }
        
        let empty = constructButton(42)
        empty.alpha = 0
        let zero = constructButton(0)
        let backspace = constructButton("<", tag: -1)
        zeroRow.addArrangedSubview(empty)
        zeroRow.addArrangedSubview(zero)
        zeroRow.addArrangedSubview(backspace)
        
        container.addArrangedSubview(topRow)
        container.addArrangedSubview(midRow)
        container.addArrangedSubview(bottomRow)
        container.addArrangedSubview(zeroRow)
        
        addSubview(container)
    }
    
    func applyConstraints(){
        container.fillSuperview()
    }
    
    func numberTapped(_ button: UIButton){
        guard let _ = delegate else { return }
        delegate?.numberTapped(button.tag)
    }
    
    func constructButton(_ number: Int) -> WindoNumber{
        let newNumber = WindoNumber()
        newNumber.setTitle(String(number), for: UIControlState())
        newNumber.tag = number
        newNumber.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        newNumber.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        newNumber.addTarget(self, action: #selector(WindoNumberPad.numberTapped(_:)), for: .touchUpInside)
        
        return newNumber
    }
    
    func constructButton(_ string: String, tag: Int) -> WindoNumber {
        let newNumber = WindoNumber()
        newNumber.setTitle(string, for: UIControlState())
        newNumber.tag = tag
        newNumber.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        newNumber.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        newNumber.addTarget(self, action: #selector(WindoNumberPad.numberTapped(_:)), for: .touchUpInside)
        
        return newNumber
    }
}

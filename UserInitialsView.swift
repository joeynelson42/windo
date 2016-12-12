//
//  UserInitialsView.swift
//  Windo
//
//  Created by Joey on 8/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class UserInitialsView: UIView {
    
    //MARK: Properties
    
    var container = UIView()
    var initials = UILabel()
    var cornerRadius: CGFloat = 0
    var fontSize: CGFloat = 15
    var name = "Yuki Dorff" {
        didSet {
            initials.text = getInitials(name)
        }
    }
    
    var borderWidth: CGFloat = 1.5
    var borderColor = UIColor.white.cgColor
    
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
        container.backgroundColor = UIColor.clear
        container.layer.borderColor = borderColor
        container.layer.borderWidth = borderWidth
        container.layer.cornerRadius = cornerRadius
        
        initials.text = getInitials(name)
        initials.textAlignment = .center
        initials.font = UIFont.graphikLight(fontSize)
        initials.textColor = UIColor.white
        
        addSubview(container)
        addSubview(initials)
    }
    
    func applyConstraints(){
        container.fillSuperview()
        initials.fillSuperview()
    }
    
    // MARK: Utilities
    
    func getInitials(_ name: String) -> String {
        if name.isEmpty {
            return ""
        }
        
        let firstInitial = "\(name[name.characters.index(name.startIndex, offsetBy: 0)])"
        
        guard let index = name.characters.index(of: " ") else {
            return firstInitial.uppercased()
        }
        
        if name.characters.distance(from: name.startIndex, to: index) + 1 >= name.characters.count {
            return firstInitial.uppercased()
        }
        
        let secondInitial = "\(name[name.characters.index(name.startIndex, offsetBy: name.characters.distance(from: name.startIndex, to: index) + 1)])"
        
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercased()
    }
}

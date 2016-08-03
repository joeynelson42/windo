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
    var name = "Yuki Dorff"
    
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
        container.backgroundColor = UIColor.clearColor()
        container.layer.borderColor = UIColor.whiteColor().CGColor
        container.layer.borderWidth = 2
        container.layer.cornerRadius = cornerRadius
        
        initials.text = getInitials(name)
        initials.textAlignment = .Center
        initials.font = UIFont.graphikLight(fontSize)
        initials.textColor = UIColor.whiteColor()
        
        addSubview(container)
        addSubview(initials)
    }
    
    func applyConstraints(){
        container.fillSuperview()
        initials.fillSuperview()
    }
    
    // MARK: Utilities
    
    func getInitials(name: String) -> String{
        let firstInitial = "\(name[name.startIndex.advancedBy(0)])"
        
        guard let index = name.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(name[name.startIndex.advancedBy(name.startIndex.distanceTo(index) + 1)])"
        
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
}
//
//  ChatCell.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    //MARK: Properties
    let container = UIView()
    let message = UILabel()
    
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
        container.layer.cornerRadius = 18
        container.backgroundColor = UIColor.darkPurple()
        
        message.text = "Hey there boy"
        message.textColor = UIColor.whiteColor()
        message.font = UIFont.graphikRegular(16)
        message.backgroundColor = UIColor.clearColor()
        
        addSubview(container)
        addSubview(message)
    }
    
    func applyConstraints(){
        container.addConstraints(
            Constraint.llrr.of(self, offset: 20),
            Constraint.ttbb.of(self, offset: 20)
        )
        
        message.addConstraints(
            Constraint.ttbb.of(self),
            Constraint.ll.of(self, offset: 11)
        )
    }
}

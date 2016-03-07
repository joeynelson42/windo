//
//  WindoViewCell.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoViewCell: UIView {
   
    
//    convenience init(position: BorderPosition, color: UIColor) {
//        self.init(frame: CGRectZero)
//        self.position = position
//        self.color = color
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    var scrollView = UIScrollView()
    var label = UILabel()
    
    //interval will be a double, 1.0 = 1 hour, 0.25 = 15 minutes, etc.
    var interval = Double()
    
    //similar to interval, 8.25 == 8:15, 16.5 == 4:30
    var startTime = Double()
    var endTime = Double()
    
    var timeArray = [Double]()
    
    //MARK: View Configuration
    
    
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        
        self.backgroundColor = UIColor.clearColor()
        
//
//        addSubview(scrollView)
        
//        label.text = "Cell"
//        label.textColor = UIColor.blackColor()
//        label.font = UIFont(name: "Avenir", size: 30)
        
        addSubview(label)
    }
    
    func applyConstraints(){
        
        label.constrainUsing(constraints: [
            .cxcx : (of: self, offset: 0),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: 100),
            .h : (of: nil, offset: 40)])
        
        
    }
}

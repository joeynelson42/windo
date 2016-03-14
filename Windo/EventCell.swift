//
//  HomeTableViewCell.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    //MARK: Properties
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var eventStatus = UILabel()
    var arrowImageView = UIImageView()
    var notificationDot = NotificationDotView()
    
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
        
        titleLabel.textColor = UIColor.mikeBlue()
        titleLabel.font = UIFont.graphikRegular(22)
        
        locationLabel.textColor = UIColor.mikeBlue()
        locationLabel.font = UIFont.graphikRegular(18)
        
        eventStatus.textColor = UIColor.whiteColor()
        eventStatus.font = UIFont.graphikRegular(16)
        
        arrowImageView.image = UIImage(named: "CellArrow")
        
        notificationDot.backgroundColor = UIColor.whiteColor()
        notificationDot.layer.cornerRadius = 5
        
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(eventStatus)
        addSubview(arrowImageView)
        addSubview(notificationDot)
    }
    
    func applyConstraints(){
        titleLabel.constrainUsing(constraints: [
            .ll : (of: self, offset: 39),
            .tt : (of: self, offset: 27),
            .w : (of: nil, offset: screenWidth),
            .h : (of: nil, offset: 22)])
        
        locationLabel.constrainUsing(constraints: [
            .ll : (of: titleLabel, offset: 0),
            .tb : (of: titleLabel, offset: 3),
            .w : (of: nil, offset: screenWidth),
            .h : (of: nil, offset: 18)])
        
        eventStatus.constrainUsing(constraints: [
            .ll : (of: titleLabel, offset: 0),
            .tb : (of: locationLabel, offset: 22),
            .w : (of: nil, offset: screenWidth),
            .h : (of: nil, offset: 16)])
        
        arrowImageView.constrainUsing(constraints: [
            .cycy : (of: self, offset: 0),
            .rr : (of: self, offset: -22),
            .w : (of: nil, offset: 9),
            .h : (of: nil, offset: 16)])
        
        notificationDot.constrainUsing(constraints: [
            .rl : (of: titleLabel, offset: -12),
            .cycy : (of: titleLabel, offset: 0),
            .w : (of: nil, offset: 10),
            .h : (of: nil, offset: 10)])
    }
}

class NotificationDotView: UIView {
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(color: UIColor) {
        self.init(frame: CGRectZero)
        self.backgroundColor = color
        self.layer.cornerRadius = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

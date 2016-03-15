//
//  EventDetailsView.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventDetailsView: UIView {
    
    //MARK: Properties
    
    //response report – Responses will be added dynamically with real data
    var respondedStackView = UIStackView()
    var response1 = ResponseCircleView()
    var response2 = ResponseCircleView()
    var response3 = ResponseCircleView()
    var response4 = ResponseCircleView()
    var responseStatus = UILabel()
    
    //location/date+time
    var separatingLine = UIView()
    var locationTitleLabel = UILabel()
    var locationLabel = UILabel()
    var dateTimeTitleLabel = UILabel()
    var dateTimeLabel = UILabel()
    
    //group members
    var addMemberCell = UIView()
    var addMemberLabel = UILabel()
    var addMemberButton = UIButton()
    var memberTableView = UITableView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightPurple()
        
        respondedStackView = UIStackView(arrangedSubviews: [response1, response2, response3, response4])
        respondedStackView.axis = .Horizontal
        respondedStackView.distribution = .EqualSpacing
        respondedStackView.spacing = 10
        
        response1.initials.text = "JN"
        response2.initials.text = "SK"
        response3.initials.text = "YK"
        response4.initials.text = "RE"
        response3.alpha = 0.18
        
        responseStatus.text = "3/4 have responded!"
        responseStatus.textColor = UIColor.darkPurple()
        responseStatus.alpha = 0.44
        responseStatus.font = UIFont.graphikRegular(12)
        responseStatus.textAlignment = .Center
        
        separatingLine.backgroundColor = UIColor.darkPurple()
        
        locationTitleLabel.text = "Location"
        locationTitleLabel.textColor = UIColor.darkPurple()
        locationTitleLabel.font = UIFont.graphikRegular(12)
        locationTitleLabel.textAlignment = .Center
        
        locationLabel.text = "Yellow Door House\n346 N 400 E Provo,UT"
        locationLabel.numberOfLines = 3
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        locationLabel.font = UIFont.graphikRegular(14)
        
        dateTimeTitleLabel.text = "Date + Time"
        dateTimeTitleLabel.textColor = UIColor.darkPurple()
        dateTimeTitleLabel.font = UIFont.graphikRegular(12)
        dateTimeTitleLabel.textAlignment = .Center
        
        dateTimeLabel.text = "September 17, 2016\n7:00 P.M."
        dateTimeLabel.numberOfLines = 3
        dateTimeLabel.textColor = UIColor.whiteColor()
        dateTimeLabel.textAlignment = .Center
        dateTimeLabel.font = UIFont.graphikRegular(14)
        
        addMemberCell.layer.borderColor = UIColor.purple().CGColor
        addMemberCell.layer.borderWidth = 1.0
        addMemberCell.backgroundColor = UIColor.lightPurple()
        
        addMemberLabel.text = "Group Members"
        addMemberLabel.textColor = UIColor.darkPurple()
        addMemberLabel.font = UIFont.graphikRegular(16)
        
        addMemberButton.setImage(UIImage(named: "AddMemberButton"), forState: .Normal)
        
        memberTableView.backgroundColor = UIColor.purple()
        memberTableView.showsVerticalScrollIndicator = false
        memberTableView.separatorColor = UIColor.darkPurple(0.7)
        memberTableView.allowsSelection = false
        memberTableView.registerClass(GroupMemberCell.self, forCellReuseIdentifier: "memberCell")
        
        addSubview(respondedStackView)
        addSubview(responseStatus)
        addSubview(separatingLine)
        addSubview(dateTimeTitleLabel)
        addSubview(dateTimeLabel)
        addSubview(locationTitleLabel)
        addSubview(locationLabel)
        addSubview(addMemberCell)
        addSubview(addMemberLabel)
        addSubview(addMemberButton)
        addSubview(memberTableView)
    }
    
    func applyConstraints(){
        respondedStackView.constrainUsing(constraints: [
            Constraint.tt : (of: self, offset: 82),
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: 44*4),
            Constraint.h : (of: nil, offset: 40)])
        
        responseStatus.constrainUsing(constraints: [
            Constraint.tb : (of: respondedStackView, offset: 16),
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: 12)])
        
        separatingLine.constrainUsing(constraints: [
            Constraint.tb : (of: responseStatus, offset: 27),
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: 1.2),
            Constraint.h : (of: nil, offset: 62)])
        
        dateTimeTitleLabel.constrainUsing(constraints: [
            Constraint.tt : (of: separatingLine, offset: 0),
            Constraint.cxcx : (of: self, offset: screenWidth * 0.25),
            Constraint.w : (of: nil, offset: screenWidth/2),
            Constraint.h : (of: nil, offset: 13)])
        
        dateTimeLabel.constrainUsing(constraints: [
            Constraint.tb : (of: dateTimeTitleLabel, offset: 6),
            Constraint.cxcx : (of: self, offset: screenWidth * 0.25),
            Constraint.w : (of: nil, offset: screenWidth/2),
            Constraint.h : (of: nil, offset: 32)])
        
        locationTitleLabel.constrainUsing(constraints: [
            Constraint.tt : (of: separatingLine, offset: 0),
            Constraint.cxcx : (of: self, offset: -(screenWidth * 0.25)),
            Constraint.w : (of: nil, offset: screenWidth/2),
            Constraint.h : (of: nil, offset: 13)])
        
        locationLabel.constrainUsing(constraints: [
            Constraint.tb : (of: locationTitleLabel, offset: 6),
            Constraint.cxcx : (of: self, offset: -(screenWidth * 0.25)),
            Constraint.w : (of: nil, offset: screenWidth/2),
            Constraint.h : (of: nil, offset: 32)])
        
        addMemberCell.constrainUsing(constraints: [
            Constraint.tb : (of: separatingLine, offset: 22),
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth + 2),
            Constraint.h : (of: nil, offset: 53)])
        
        addMemberLabel.constrainUsing(constraints: [
            Constraint.cycy : (of: addMemberCell, offset: 0),
            Constraint.ll : (of: addMemberCell, offset: 19),
            Constraint.w : (of: nil, offset: 200),
            Constraint.h : (of: nil, offset: 20)])
        
        addMemberButton.constrainUsing(constraints: [
            Constraint.cycy : (of: addMemberCell, offset: 0),
            Constraint.rr : (of: addMemberCell, offset: -25),
            Constraint.w : (of: nil, offset: 30),
            Constraint.h : (of: nil, offset: 30)])
        
        memberTableView.constrainUsing(constraints: [
            Constraint.tb : (of: addMemberCell, offset: 0),
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: screenWidth),
            Constraint.h : (of: nil, offset: screenHeight - 363)])
    }
}

class ResponseCircleView: UIView {
    
    //MARK: Properties
    var initials = UILabel()
    var backgroundView = UIView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundView.backgroundColor = UIColor.purple()
        backgroundView.layer.cornerRadius = 17
        
        initials.font = UIFont.graphikRegular(14)
        initials.textColor = UIColor.whiteColor()
        initials.textAlignment = .Center
        
        addSubview(backgroundView)
        addSubview(initials)
    }
    
    func applyConstraints(){
        
        initials.constrainUsing(constraints: [
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.cycy : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: 34),
            Constraint.h : (of: nil, offset: 34)])
        
        backgroundView.constrainUsing(constraints: [
            Constraint.cxcx : (of: self, offset: 0),
            Constraint.cycy : (of: self, offset: 0),
            Constraint.w : (of: nil, offset: 34),
            Constraint.h : (of: nil, offset: 34)])
    }
}
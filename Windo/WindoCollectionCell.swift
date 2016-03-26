//
//  WindoCollectionCell.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoCollectionCell: UICollectionViewCell, WindoTimeCellDelegate {
    
    //MARK: Properties
    var date = NSDate()
    
    //date header
    var dayNumberLabel = UILabel()
    var weekdayLabel = UILabel()
    var amLabel = UILabel()
    var pmLabel = UILabel()
    
    
    var scrollView = UIScrollView()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //times
    var time1 = WindoTimeCell()
    var time2 = WindoTimeCell()
    var time3 = WindoTimeCell()
    var time4 = WindoTimeCell()
    var time5 = WindoTimeCell()
    var time6 = WindoTimeCell()
    var time7 = WindoTimeCell()
    var time8 = WindoTimeCell()
    var time9 = WindoTimeCell()
    var time10 = WindoTimeCell()
    var time11 = WindoTimeCell()
    var time12 = WindoTimeCell()
    var time13 = WindoTimeCell()
    var time14 = WindoTimeCell()
    var time15 = WindoTimeCell()
    var time16 = WindoTimeCell()
    var time17 = WindoTimeCell()
    var time18 = WindoTimeCell()
    var time19 = WindoTimeCell()
    var time20 = WindoTimeCell()
    var time21 = WindoTimeCell()
    var time22 = WindoTimeCell()
    var time23 = WindoTimeCell()
    var time24 = WindoTimeCell()
    
    var times = [WindoTimeCell]()
    var selectedTimes = [Int]()
    
    let timeWidth: CGFloat = 100
    let timeHeight: CGFloat = 20
    let timeSpacing: CGFloat = 34
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        times = [time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23, time24]
        
        configureDateData()
        
        dayNumberLabel.font = UIFont.graphikRegular(12)
        dayNumberLabel.textColor = UIColor.whiteColor()
        dayNumberLabel.textAlignment = .Center
        
        weekdayLabel.font = UIFont.graphikMedium(16)
        weekdayLabel.textColor = UIColor.whiteColor()
        weekdayLabel.textAlignment = .Center
        
        amLabel.text = "AM"
        amLabel.textColor = UIColor.darkBlue()
        amLabel.font = UIFont.graphikRegular(10)
        amLabel.textAlignment = .Center
        
        pmLabel.text = "PM"
        pmLabel.textColor = UIColor.darkBlue()
        pmLabel.font = UIFont.graphikRegular(10)
        pmLabel.textAlignment = .Center
        
        scrollView.contentSize = CGSize(width: screenWidth/2, height: (CGFloat(times.count) * (timeHeight + timeSpacing) + 70))
        scrollView.showsVerticalScrollIndicator = false
        
        addSubview(scrollView)
        
        addSubview(dayNumberLabel)
        addSubview(weekdayLabel)
        
        scrollView.addSubviews(time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23, time24)
        
        scrollView.addSubview(amLabel)
        scrollView.addSubview(pmLabel)
    }
    
    func applyConstraints(){
        dayNumberLabel.addConstraints(
            Constraint.tt.of(self, offset: 8),
            Constraint.cxcx.of(self),
            Constraint.w.of(100),
            Constraint.h.of(12)
        )
        
        weekdayLabel.addConstraints(
            Constraint.tb.of(dayNumberLabel, offset: 3),
            Constraint.cxcx.of(self),
            Constraint.w.of(100),
            Constraint.h.of(16)
        )
        
        scrollView.addConstraints(
            Constraint.tb.of(weekdayLabel, offset: 15),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth/2),
            Constraint.h.of(screenHeight - 115)
        )
        
        amLabel.addConstraints(
            Constraint.tt.of(scrollView, offset: 7),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(100),
            Constraint.h.of(10)
        )
        
        time1.addConstraints(
            Constraint.tb.of(amLabel, offset: 21),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time2.addConstraints(
            Constraint.tb.of(time1, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time3.addConstraints(
            Constraint.tb.of(time2, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time4.addConstraints(
            Constraint.tb.of(time3, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time5.addConstraints(
            Constraint.tb.of(time4, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time6.addConstraints(
            Constraint.tb.of(time5, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time7.addConstraints(
            Constraint.tb.of(time6, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time8.addConstraints(
            Constraint.tb.of(time7, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time9.addConstraints(
            Constraint.tb.of(time8, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time10.addConstraints(
            Constraint.tb.of(time9, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time11.addConstraints(
            Constraint.tb.of(time10, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time12.addConstraints(
            Constraint.tb.of(time11, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        pmLabel.addConstraints(
            Constraint.tb.of(time12, offset: 36),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(100),
            Constraint.h.of(10)
        )
        
        time13.addConstraints(
            Constraint.tb.of(pmLabel, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time14.addConstraints(
            Constraint.tb.of(time13, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time15.addConstraints(
            Constraint.tb.of(time14, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time16.addConstraints(
            Constraint.tb.of(time15, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time17.addConstraints(
            Constraint.tb.of(time16, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time18.addConstraints(
            Constraint.tb.of(time17, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time19.addConstraints(
            Constraint.tb.of(time18, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time20.addConstraints(
            Constraint.tb.of(time19, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time21.addConstraints(
            Constraint.tb.of(time20, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time22.addConstraints(
            Constraint.tb.of(time21, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time23.addConstraints(
            Constraint.tb.of(time22, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
        
        time24.addConstraints(
            Constraint.tb.of(time23, offset: timeSpacing),
            Constraint.cxcx.of(scrollView),
            Constraint.w.of(timeWidth),
            Constraint.h.of(timeHeight)
        )
    }
    
    override func prepareForReuse() {
        for time in times {
            if selectedTimes.contains(time.time) {
                time.forceHighlight()
            }
            else {
                time.forceUnhighlight()
            }
        }
    }
    
    func configureDateData(){
        dayNumberLabel.text = "\(date.day())"
        weekdayLabel.text = date.abbrevDayOfWeek()
        
        time1 = WindoTimeCell(cellTime: 12, cellDelegate: self)
        time2 = WindoTimeCell(cellTime: 1, cellDelegate: self)
        time3 = WindoTimeCell(cellTime: 2, cellDelegate: self)
        time4 = WindoTimeCell(cellTime: 3, cellDelegate: self)
        time5 = WindoTimeCell(cellTime: 4, cellDelegate: self)
        time6 = WindoTimeCell(cellTime: 5, cellDelegate: self)
        time7 = WindoTimeCell(cellTime: 6, cellDelegate: self)
        time8 = WindoTimeCell(cellTime: 7, cellDelegate: self)
        time9 = WindoTimeCell(cellTime: 8, cellDelegate: self)
        time10 = WindoTimeCell(cellTime: 9, cellDelegate: self)
        time11 = WindoTimeCell(cellTime: 10, cellDelegate: self)
        time12 = WindoTimeCell(cellTime: 11, cellDelegate: self)
        time13 = WindoTimeCell(cellTime: 1, cellDelegate: self)
        time14 = WindoTimeCell(cellTime: 2, cellDelegate: self)
        time15 = WindoTimeCell(cellTime: 3, cellDelegate: self)
        time16 = WindoTimeCell(cellTime: 4, cellDelegate: self)
        time17 = WindoTimeCell(cellTime: 5, cellDelegate: self)
        time18 = WindoTimeCell(cellTime: 6, cellDelegate: self)
        time19 = WindoTimeCell(cellTime: 7, cellDelegate: self)
        time20 = WindoTimeCell(cellTime: 8, cellDelegate: self)
        time21 = WindoTimeCell(cellTime: 9, cellDelegate: self)
        time22 = WindoTimeCell(cellTime: 10, cellDelegate: self)
        time23 = WindoTimeCell(cellTime: 11, cellDelegate: self)
        time24 = WindoTimeCell(cellTime: 12, cellDelegate: self)
        
        times = [time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23, time24]
    }
    
    func updateDateData(){
        dayNumberLabel.text = "\(date.day())"
        weekdayLabel.text = date.abbrevDayOfWeek()
    }
    
    func updateSelectedTimes(time: Int) {
        if selectedTimes.contains(time){
            selectedTimes.removeAtIndex(selectedTimes.indexOf(time)!)
        }
        else {
            selectedTimes.append(time)
        }
    }
}
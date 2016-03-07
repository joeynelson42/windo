//
//  WindoSelectView.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoSelectView: UIView {
    
    //MARK: Properties
    var windoCarouselView = iCarousel()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        windoCarouselView.delegate = self
        windoCarouselView.dataSource = self
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(windoCarouselView)
    }
    
    func applyConstraints(){
        windoCarouselView.constrainUsing(constraints: [
            .cxcx : (of: self, offset: 0),
            .cycy : (of: self, offset: 0),
            .w : (of: nil, offset: screenWidth),
            .h : (of: nil, offset: screenHeight)])
    }
}


//MARK: iCarousel Delegate/DataSource Methods
extension WindoSelectView: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var scrollView = UIScrollView()
        var itemView: WindoViewCell
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = WindoViewCell(frame:CGRect(x:0, y:0, width:screenWidth/2.5, height:screenHeight))
            itemView.contentMode = .Center
            
            
            scrollView.tag = 1
            itemView.addSubview(scrollView)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! WindoViewCell;
            scrollView = itemView.viewWithTag(1) as! UIScrollView!
        }
        
        itemView.backgroundColor = UIColor.clearColor()

        scrollView = createScrollView(itemView)
        scrollView.contentSize = CGSizeMake(itemView.frame.width, screenHeight * 2)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
    func createScrollView(parentView: WindoViewCell) -> UIScrollView{
        let scrollView = UIScrollView()
        let timeArray = createTimeArray(2.0, endTime: 18.0, interval: 1.0)
        
        parentView.addSubview(scrollView)

        scrollView.constrainUsing(constraints: [
            .cxcx : (of: parentView, offset: 0),
            .cycy : (of: parentView, offset: 0),
            .w : (of: nil, offset: parentView.frame.width),
            .h : (of: nil, offset: screenHeight)])
        
        for (index, time) in timeArray.enumerate() {
            let newTime = WindoButton()
            newTime.setTitle("\(Int(time)):00", forState: .Normal)
            newTime.titleLabel?.font = UIFont(name: "Avenir", size: 15)
            newTime.setTitleColor(UIColor.blackColor(), forState: .Normal)
            newTime.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
            
            scrollView.addSubview(newTime)
            
            let heightConstraint = CGFloat(index * 50 + 100)
            newTime.constrainUsing(constraints: [
                .cxcx : (of: scrollView, offset: 0),
                .tt : (of: scrollView, offset: heightConstraint),
                .w : (of: nil, offset: 40),
                .h : (of: nil, offset: 25)])
        }

        
        
        return scrollView
    }
    
    
    func createTimeArray(startTime: Double, endTime: Double, interval: Double) -> [Double]{
        var start = startTime
        let end = endTime
        var timeArray = [Double]()
        
        while start < end {
            timeArray.append(start)
            start += interval
        }
        
        return timeArray
    }
    
    func timeArraytoNSDate() -> [NSDate] {
        let times = [NSDate]()
        
        return times
    }

    
}




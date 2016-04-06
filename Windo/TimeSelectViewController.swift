//
//  TimeSelectViewController.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TimeSelectViewController: UIViewController, TimeViewDelegate {
    
    //MARK: Properties
    var createTabBar: CreateTabBarController!
    var timeSelectView: TimeSelectView!
    var initialStates = [CGFloat]()
    var date = NSDate()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        timeSelectView = TimeSelectView(timeDelegate: self, timeDate: NSDate())
        view = timeSelectView
        createTabBar = (tabBarController as! CreateTabBarController)
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(TimeSelectViewController.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimeSelectViewController.handleCalendarGesture(_:)))
        
        timeSelectView.dragView.addGestureRecognizer(drag)
        timeSelectView.dragView.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createTabBar.title = "Specify Times"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.backTapped))
        createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
    }
    
    func updateSelectedTimes(time: Int) {
        let newTime = createDateWithComponents(date.year(), monthNumber: date.month(), dayNumber: date.day(), hourNumber: time)
        
        print(newTime)
    }
    
    func backTapped(){
        createTabBar.selectedIndex = 1
    }
    
    func doneTapped(){
        let alertController = UIAlertController(title: "Hey!", message: "Ready to send out the invites?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Not yet!", style: .Default) { (action) in}
        alertController.addAction(cancelAction)
        
        let sendAction = UIAlertAction(title: "Send!", style: .Default) { (action) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(sendAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        initialStates.removeAll()
        let times = timeSelectView.times
        for time in times {
            initialStates.append(time.selectedBackground.alpha)
        }
    }
    
    func handleCalendarGesture(gesture: UIGestureRecognizer){
        let times = timeSelectView.times
        
        for (index,time) in times.enumerate() {
            if time.frame.contains(gesture.locationInView(timeSelectView)){
                if (time.selectedBackground.alpha == initialStates[index]){
                    time.handleTap()
                }
            }
        }
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber - 6
        components.minute = 0
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
}
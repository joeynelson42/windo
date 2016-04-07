//
//  TimeSelectViewController.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TimeSelectViewController: UIViewController {
    
    //MARK: Properties
    var createTabBar: CreateTabBarController!
    var timeSelectView = TimeSelectView()
    var timeCollectionView: UICollectionView!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = timeSelectView
        createTabBar = (tabBarController as! CreateTabBarController)
        configureCollectionView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createTabBar.title = "Specify Times"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.backTapped))
        createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        
        timeCollectionView.reloadData()
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
}

extension TimeSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - 64)
        timeCollectionView = UICollectionView(frame: timeSelectView.frame, collectionViewLayout: layout)
                
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.registerClass(TimeSelectCollectionViewCell.self, forCellWithReuseIdentifier: "timeSelectCell")
        timeCollectionView.backgroundColor = UIColor.clearColor()
        timeCollectionView.showsVerticalScrollIndicator = false
        timeCollectionView.pagingEnabled = true
        timeSelectView.addSubview(timeCollectionView)
        
        timeCollectionView.addConstraints(
            Constraint.tt.of(timeSelectView),
            Constraint.cxcx.of(timeSelectView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 64)
        )
        
        timeSelectView.bringSubviewToFront(timeCollectionView)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createTabBar.selectedDates.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeCollectionView.dequeueReusableCellWithReuseIdentifier("timeSelectCell", forIndexPath: indexPath) as! TimeSelectCollectionViewCell
        
        cell.date = createTabBar.selectedDates[indexPath.row]
        cell.dateLabel.text = "\(cell.date.monthAbbrevCap()) \(cell.date.day())"
        cell.dayOfTheWeekLabel.text = "\(cell.date.abbrevDayOfWeek())"
        cell.delegate = self
        
        var selectedTimeIndices = [Int]()
        for time in createTabBar.selectedTimes {
            if time.fullDate() == cell.date.fullDate() {
                var selectedTime = time.hour()
                selectedTimeIndices.append(selectedTime)
            }
        }
        
        cell.configureTimes()
        cell.updateTimesStates(selectedTimeIndices)
        
        return cell
    }
}

extension TimeSelectViewController: TimeSelectCollectionViewCellDelegate {
    func updateSelectedTimes(date: NSDate, time: Int) {
        let newTime = createDateWithComponents(date.year(), monthNumber: date.month(), dayNumber: date.day(), hourNumber: time)
        print(newTime)
        
        if createTabBar.selectedTimes.contains(newTime){
            guard let index = createTabBar.selectedTimes.indexOf(newTime) else { return }
            createTabBar.selectedTimes.removeAtIndex(index)
        }
        else {
            createTabBar.selectedTimes.append(newTime)
        }
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = 0
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
}




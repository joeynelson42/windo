//
//  WindoTimeViewController.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoTimeViewController: UIViewController {
    
    //MARK: Properties
    var parentVC: CreateEventViewController!
    var windoTimeView = WindoTimeView()
    var timeCollectionView: UICollectionView!
    
    var dates = [NSDate]()
    
    //MARK: Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)   {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(selectedDates: [NSDate], parent: CreateEventViewController){
        self.init(nibName: nil, bundle:nil)
        
        dates = selectedDates
        parentVC = parent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = windoTimeView
        configureCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        timeCollectionView.reloadData()
    }
}

extension WindoTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, WindoCollectionCellDelegate {
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: screenWidth/3, height: screenHeight - 70)
        timeCollectionView = UICollectionView(frame: windoTimeView.frame, collectionViewLayout: layout)
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.registerClass(WindoCollectionCell.self, forCellWithReuseIdentifier: "windoCell")
        timeCollectionView.backgroundColor = UIColor.clearColor()
        timeCollectionView.showsVerticalScrollIndicator = false
        
        windoTimeView.addSubview(timeCollectionView)
        
        timeCollectionView.addConstraints(
            Constraint.tt.of(windoTimeView),
            Constraint.cxcx.of(windoTimeView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 64)
        )
        
        windoTimeView.bringSubviewToFront(timeCollectionView)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("windoCell", forIndexPath: indexPath) as! WindoCollectionCell
        cell.delegate = self
        cell.date = dates[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        cell.updateDateData()
        
        return cell
    }
    
    func updateSelectedTimes(date: NSDate, time: Int) {
        let date = createDateWithComponents(date, time: time)
        
        if parentVC.selectedTimes.contains(date) {
            if let index = parentVC.selectedTimes.indexOf(date) {
                parentVC.selectedTimes.removeAtIndex(index)
            }
        }
        else {
            parentVC.selectedTimes.append(date)
        }
    }
    
    func isTimeSelected(date: NSDate, time: Int) -> Bool {
        let date = createDateWithComponents(date, time: time)
        if parentVC.selectedTimes.contains(date) {
            return true
        }
        else {
            return false
        }
    }
    
    func createDateWithComponents(date: NSDate, time: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = date.year()
        components.month = date.month()
        components.day = date.day()
        components.hour = time
        components.minute = 0
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        return date
    }
}
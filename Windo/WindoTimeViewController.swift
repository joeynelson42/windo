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
    
    var windoTimeView = WindoTimeView()
    var timeCollectionView: UICollectionView!
    
    var dates = [NSDate]()
    
    //MARK: Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)   {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(selectedDates: [NSDate]){
        self.init(nibName: nil, bundle:nil)
        
        dates = selectedDates
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = windoTimeView
        configureCollectionView()
        
    }
}

extension WindoTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        cell.date = dates[indexPath.row]
        cell.updateDateData()
//        cell.updateTimes()
        cell.backgroundColor = UIColor.clearColor()
    
        return cell
    }
    
//    func updateCellTimes(){
//        for time in times {
//            time.selectedBackground.alpha = 0.0
//            time.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
//        }
//    }
}
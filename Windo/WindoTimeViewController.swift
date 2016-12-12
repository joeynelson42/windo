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
    var createTabBar: CreateTabBarController!
    var windoTimeView = WindoTimeView()
    var timeCollectionView: UICollectionView!
    
    var setOffset = false
    
    var dates = [Date]()
    
    //MARK: Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(selectedDates: [Date]){
        self.init(nibName: nil, bundle:nil)
        dates = selectedDates
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        createTabBar = (tabBarController as! CreateTabBarController)
        view = windoTimeView
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timeCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createTabBar.title = "Specify Times"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WindoTimeViewController.backTapped))
        createTabBar.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WindoTimeViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        setOffset = true
        timeCollectionView.reloadItems(at: timeCollectionView.indexPathsForVisibleItems)
        
    }
    
    func doneTapped(){
        let alertController = UIAlertController(title: "Hey!", message: "Ready to send out the invites?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Not yet!", style: .default) { (action) in}
        alertController.addAction(cancelAction)
        
        let sendAction = UIAlertAction(title: "Send!", style: .default) { (action) in
            let _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(sendAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func backTapped(){
        createTabBar.selectedIndex = 1
    }
}

extension WindoTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, WindoCollectionCellDelegate {
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth/3, height: screenHeight - 70)
        timeCollectionView = UICollectionView(frame: windoTimeView.frame, collectionViewLayout: layout)
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.register(WindoCollectionCell.self, forCellWithReuseIdentifier: "windoCell")
        timeCollectionView.backgroundColor = UIColor.clear
        timeCollectionView.showsVerticalScrollIndicator = false
        
        windoTimeView.addSubview(timeCollectionView)
        
        timeCollectionView.addConstraints(
            Constraint.tt.of(windoTimeView),
            Constraint.cxcx.of(windoTimeView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 64)
        )
        
        windoTimeView.bringSubview(toFront: timeCollectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "windoCell", for: indexPath) as! WindoCollectionCell
        cell.delegate = self
        cell.date = dates[(indexPath as NSIndexPath).row]
        cell.backgroundColor = UIColor.clear
        cell.updateDateData()
        
//        if setOffset {
//            cell.scrollView.setContentOffset(CGPointMake(0, 430), animated: false)
//        }
        
        return cell
    }
    
    func updateSelectedTimes(_ date: Date, time: Int) {
        let date = createDateWithComponents(date, time: time)
        let createVC = createTabBar.viewControllers![1] as! CreateEventViewController
        
        if createVC.selectedTimes.contains(date) {
            if let index = createVC.selectedTimes.index(of: date) {
                createVC.selectedTimes.remove(at: index)
            }
        }
        else {
            createVC.selectedTimes.append(date)
        }
    }
    
    func isTimeSelected(_ date: Date, time: Int) -> Bool {
        let date = createDateWithComponents(date, time: time)
        let createVC = createTabBar.viewControllers![1] as! CreateEventViewController
        
        if createVC.selectedTimes.contains(date) {
            return true
        }
        else {
            return false
        }
    }
    
    func createDateWithComponents(_ date: Date, time: Int) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var components = DateComponents()
        components.year = date.year()
        components.month = date.month()
        components.day = date.day()
        components.hour = time
        components.minute = 0
        components.second = 0
        guard let date = calendar.date(from: components) else { return Date() }
        return date
    }
}

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
    var scrubber: UICollectionView!
    
    var timesScrolling = false
    var scrubberScrolling = false
    var hasLaidOutViews = false
    var scrubberSelectedIndex = 1
    var cellExpandedRowIndex = 0
    
    var red:CGFloat = 0
    var green:CGFloat = 0
    var blue:CGFloat = 0
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = timeSelectView
        createTabBar = (tabBarController as! CreateTabBarController)
        configureScrubber()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasLaidOutViews {
            hasLaidOutViews = true
            timeCollectionView.collectionViewLayout.collectionViewContentSize
            scrubber.collectionViewLayout.collectionViewContentSize
            
            let timePoint = CGPoint(x: screenWidth, y: timeCollectionView.contentOffset.y)
            let scrubPoint = CGPoint(x: screenWidth/5, y: scrubber.contentOffset.y)
            timeCollectionView.setContentOffset(timePoint, animated: false)
            scrubber.setContentOffset(scrubPoint, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createTabBar.title = "Specify Times"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TimeSelectViewController.backTapped))
        createTabBar.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TimeSelectViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        timeCollectionView.reloadData()
        scrubber.reloadData()
    }
    
    func backTapped(){
        createTabBar.selectedIndex = 0
    }
    
    func doneTapped(){
        let alertController = UIAlertController(title: "Hey!", message: "Ready to send out the invites?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Not yet!", style: .default) { (action) in}
        alertController.addAction(cancelAction)
        
        let sendAction = UIAlertAction(title: "Send!", style: .default) { (action) in
            self.createTabBar.finalizeEvent()
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(sendAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension TimeSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - 64)
        timeCollectionView = UICollectionView(frame: timeSelectView.frame, collectionViewLayout: layout)
        timeCollectionView.tag = 0
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.register(SubmitTimesCollectionViewCell.self, forCellWithReuseIdentifier: "timeSelectCell")
        timeCollectionView.backgroundColor = UIColor.blue()
        timeCollectionView.showsVerticalScrollIndicator = false
        timeCollectionView.showsHorizontalScrollIndicator = false
        timeCollectionView.isPagingEnabled = true
        timeCollectionView.backgroundColor = UIColor.blue()
        timeSelectView.addSubview(timeCollectionView)
        
        timeCollectionView.addConstraints(
            Constraint.tb.of(scrubber),
            Constraint.cxcx.of(timeSelectView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 124)
        )
        
        timeSelectView.bringSubview(toFront: timeCollectionView)
    }
    
    func configureScrubber(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth/2 - screenWidth/10, bottom: 0, right: screenWidth/2 - screenWidth/10)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth / 5, height: 50)
        scrubber = UICollectionView(frame: timeSelectView.frame, collectionViewLayout: layout)
        scrubber.tag = 1
        scrubber.isPagingEnabled = false
        scrubber.delegate = self
        scrubber.dataSource = self
        scrubber.register(ScrubberCell.self, forCellWithReuseIdentifier: "scrubberCell")
        scrubber.backgroundColor = UIColor.clear
        scrubber.showsVerticalScrollIndicator = false
        scrubber.showsHorizontalScrollIndicator = false
        scrubber.backgroundColor = UIColor.darkBlue()
        timeSelectView.addSubview(scrubber)
        
        scrubber.addConstraints(
            Constraint.tt.of(timeSelectView),
            Constraint.cxcx.of(timeSelectView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        timeSelectView.bringSubview(toFront: timeSelectView.scrubberCenter)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createTabBar.selectedDates.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = timeCollectionView.dequeueReusableCell(withReuseIdentifier: "timeSelectCell", for: indexPath) as! SubmitTimesCollectionViewCell
            cell.backgroundColor = UIColor.clear
            
            var expandRowImage = UIImage(named: "expandArrow")
            if (indexPath as NSIndexPath).row == 0 {
                let date = Date.createDateWithComponents(1991, monthNumber: 4, dayNumber: 23, hourNumber: 0, minuteNumber: 0)
                cell.updateWithDate(date)
                expandRowImage = UIImage(named: "blueLeftArrow")
                cell.helpLabel.text = "Select times for all your days,\nall at once!"
                cell.helpLabel.textColor = UIColor.darkBlue()
            }
            else {
                cell.updateWithDate(createTabBar.selectedDates[(indexPath as NSIndexPath).row - 1])
                cell.helpLabel.text = "Select some times for your friends to choose from!"
                cell.helpLabel.textColor = UIColor.white
            }
            cell.delegate = self
            for time in cell.times {
                time.updateWithState(stateForTime(time.time))
            }
            cell.expandRow1Button.setImage(expandRowImage, for: UIControlState())
            cell.expandRow2Button.setImage(expandRowImage, for: UIControlState())
            cell.expandRow3Button.setImage(expandRowImage, for: UIControlState())
            cell.expandRow4Button.setImage(expandRowImage, for: UIControlState())
            
            return cell
        }
        else {
            let cell = scrubber.dequeueReusableCell(withReuseIdentifier: "scrubberCell", for: indexPath) as! ScrubberCell
            
            if (indexPath as NSIndexPath).row == 0 {
                cell.allDaysLabel.alpha = 0.5
                cell.dateLabel.text = ""
                cell.dayOfTheWeekLabel.text = ""
                cell.tag = (indexPath as NSIndexPath).row
                
                return cell
            }
            
            if (indexPath as NSIndexPath).row == scrubberSelectedIndex {
                cell.dateLabel.alpha = 1.0
                cell.dayOfTheWeekLabel.alpha = 1.0
            }
            else {
                cell.dayOfTheWeekLabel.alpha = 0.5
                cell.dateLabel.alpha = 0.5
            }
            
            cell.allDaysLabel.alpha = 0.0
            let date = createTabBar.selectedDates[(indexPath as NSIndexPath).row - 1]
            cell.tag = (indexPath as NSIndexPath).row
            cell.dateLabel.text = "\(date.monthAbbrevCap()) \(date.day())"
            cell.dayOfTheWeekLabel.text = "\(date.abbrevDayOfWeek())"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            unhighlightScrubberCenter()
            
            let timePoint = CGPoint(x: screenWidth * CGFloat((indexPath as NSIndexPath).row), y: timeCollectionView.contentOffset.y)
            let scrubPoint = CGPoint(x: (screenWidth / 5) * CGFloat((indexPath as NSIndexPath).row), y: scrubber.contentOffset.y)
            
            timeCollectionView.setContentOffset(timePoint, animated: true)
            scrubber.setContentOffset(scrubPoint, animated: true)
            
            let cell = scrubber.cellForItem(at: indexPath) as! ScrubberCell
            scrubberSelectedIndex = cell.tag
            cell.fadeIn()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if timesScrolling == false && scrubberScrolling == false {
            if scrollView.tag == 0{
                timesScrolling = true
            }
            else {
                scrubberScrolling = true
            }
        }
        
        let cellCount = CGFloat(createTabBar.selectedDates.count)
        if scrollView.tag == 0  && timesScrolling == true{
            let percent = scrollView.contentOffset.x/(screenWidth * cellCount)
            
            let scrubberCellWidth = cellCount * (screenWidth/5)
            scrubber.contentOffset.x = scrubberCellWidth * percent
        }
        else if scrollView.tag == 1 && scrubberScrolling == true {
            let percent = scrollView.contentOffset.x/(screenWidth/5 * cellCount)
            
            let scrubberCellWidth = cellCount * (screenWidth)
            timeCollectionView.contentOffset.x = scrubberCellWidth * percent
        }
        
        if scrollView.tag == 0 {
            let percent = scrollView.contentOffset.x/(screenWidth * CGFloat(createTabBar.selectedDates.count))
            let allDaysThreshold = screenWidth / (screenWidth * CGFloat(createTabBar.selectedDates.count))
            
            var tempPercent:CGFloat = 0
            
            
            if percent <= allDaysThreshold{
                tempPercent = percent / allDaysThreshold
            } else {
                tempPercent = 1.0
            }
            let backgroundRGB = transitionColorToColor(UIColor.white, toColor: UIColor.blue(), percent: tempPercent)
            
            red = backgroundRGB.red
            green = backgroundRGB.green
            blue = backgroundRGB.blue
            
            timeCollectionView.backgroundColor = UIColor(red:red/256, green:green/256, blue:blue/256, alpha: 1.0)
//            timeSelectView.allDaysHelpLabel.alpha = 1 - tempPercent
//            timeSelectView.helpLabel.alpha = tempPercent
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        unhighlightScrubberCenter()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // handle paging manually for scrubber
        if scrollView.tag == 1 {
            handleScrubberPaging()
        }
        
        timesScrolling = false
        scrubberScrolling = false
        highlightScrubberCenter()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // handle paging manually for scrubber
        if scrollView.tag == 1 && !decelerate {
            handleScrubberPaging()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        timesScrolling = false
        scrubberScrolling = false
    }
    
    func handleScrubberPaging() {
        let cellCount = CGFloat(createTabBar.selectedDates.count)
        var pagingOffsets = [CGFloat]()
        for i in 0...Int(cellCount) {
            pagingOffsets.append(CGFloat(i) * (screenWidth/5))
        }
        
        let currentOffset = scrubber.contentOffset.x
        var closestOffset: CGFloat = 0
        for offset in pagingOffsets {
            if abs(currentOffset - closestOffset) > abs(currentOffset - offset) {
                closestOffset = offset
            }
        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.scrubber.contentOffset.x = closestOffset
            }, completion: { (finished) in
                self.highlightScrubberCenter()
        })
    }
    
    func highlightScrubberCenter(){
        if let indexPath = scrubber.indexPathForItem(at: timeSelectView.convert(timeSelectView.scrubberCenter.center, to: scrubber)) {
            let cell = scrubber.cellForItem(at: indexPath) as! ScrubberCell
            cell.fadeIn()
            scrubberSelectedIndex = cell.tag
        }
    }
    
    func unhighlightScrubberCenter(){
        if let indexPath = scrubber.indexPathForItem(at: timeSelectView.convert(timeSelectView.scrubberCenter.center, to: scrubber)) {
            let cell = scrubber.cellForItem(at: indexPath) as! ScrubberCell
            cell.fadeOut()
        }
    }
}

extension TimeSelectViewController: SubmitTimesCollectionViewCellDelegate {
    func timeCellStateChanged(_ newState: TimeCellState, date: Date) {
        if date.fullDate() == createDateWithComponents(1991, monthNumber: 4, dayNumber: 23, hourNumber: 0).fullDate() {
            createTabBar.addAllDaysTime(date)
            return
        }
        
        switch newState {
        case .selected:
            createTabBar.selectedTimes.append(date)
        case .unselected:
            guard let index = createTabBar.selectedTimes.index(of: date) else { return }
            createTabBar.selectedTimes.remove(at: index)
        default:
            break
        }
    }
    
    func stateForTime(_ time: Date) -> TimeCellState {
        if createTabBar.selectedTimes.contains(time) {
            return TimeCellState.selected
        } else {
            return TimeCellState.unselected
        }
    }
    
    func rowExpanded(_ rowIndex: Int) {
        cellExpandedRowIndex = rowIndex
    }
    
    func expandedRowIndex() -> Int {
        return cellExpandedRowIndex
    }
    
    func createDateWithComponents(_ yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var components = DateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = 0
        components.second = 0
        guard let date = calendar.date(from: components) else { return Date() }
        
        return date
    }
    
    func transitionColorToColor(_ fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat){
        let fromRGB = fromColor.rgb()!
        let toRGB = toColor.rgb()!
        
        red = fromRGB.red + (percent * (toRGB.red - fromRGB.red))
        green = fromRGB.green + (percent * (toRGB.green - fromRGB.green))
        blue = fromRGB.blue + (percent * (toRGB.blue - fromRGB.blue))
        
        return (red: red, green: green, blue: blue)
    }
}




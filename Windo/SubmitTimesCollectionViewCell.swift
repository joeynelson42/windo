//
//  SubmitTimesCollectionViewCell.swift
//  Windo
//
//  Created by Joey Nelson on 7/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol SubmitTimesCollectionViewCellDelegate {
    func stateForTime(time: NSDate) -> TimeCellState
    func timeCellStateChanged(newState: TimeCellState, date: NSDate)
    func rowExpanded(rowIndex: Int)
    func expandedRowIndex() -> Int
}

enum SubmitTimesCollectionViewCellState: Int {
    case closed = 0
    case row1Expanded = 1
    case row2Expanded = 2
    case row3Expanded = 3
    case row4Expanded = 4
}

class SubmitTimesCollectionViewCell: UICollectionViewCell, ExpandingTimeCellDelegate {
    
    //MARK: Properties
    var delegate: SubmitTimesCollectionViewCellDelegate!
    var date = NSDate()
    var colorTheme = ColorTheme(color: .blue)
    var state = SubmitTimesCollectionViewCellState.closed
    var times = [TimeCell]()
    var initialStates = [CGFloat]()
    var toggledButton = UIButton()
    
    var cellContainer = UIView()
    var tapContainer = UIView()
    
    let amLabel = UILabel()
    let pmLabel = UILabel()
    let helpLabel = UILabel()
    
    var cells = [ExpandingTimeCell]()
    var row1 = [ExpandingTimeCell]()
    var row2 = [ExpandingTimeCell]()
    var row3 = [ExpandingTimeCell]()
    var row4 = [ExpandingTimeCell]()
    
    var expandRow1Button = UIButton()
    var expandRow2Button = UIButton()
    var expandRow3Button = UIButton()
    var expandRow4Button = UIButton()
    
    //row 1
    var timeCell0 = ExpandingTimeCell()
    var timeCell1 = ExpandingTimeCell()
    var timeCell2 = ExpandingTimeCell()
    var timeCell3 = ExpandingTimeCell()
    var timeCell4 = ExpandingTimeCell()
    var timeCell5 = ExpandingTimeCell()
    var timeCell6 = ExpandingTimeCell()
    var timeCell7 = ExpandingTimeCell()
    var timeCell8 = ExpandingTimeCell()
    var timeCell9 = ExpandingTimeCell()
    var timeCell10 = ExpandingTimeCell()
    var timeCell11 = ExpandingTimeCell()
    var timeCell12 = ExpandingTimeCell()
    var timeCell13 = ExpandingTimeCell()
    var timeCell14 = ExpandingTimeCell()
    var timeCell15 = ExpandingTimeCell()
    var timeCell16 = ExpandingTimeCell()
    var timeCell17 = ExpandingTimeCell()
    var timeCell18 = ExpandingTimeCell()
    var timeCell19 = ExpandingTimeCell()
    var timeCell20 = ExpandingTimeCell()
    var timeCell21 = ExpandingTimeCell()
    var timeCell22 = ExpandingTimeCell()
    var timeCell23 = ExpandingTimeCell()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Configuration
    override func prepareForReuse() {
        for time in times {
            time.updateWithState(.unselected)
        }
        
        if state.rawValue != delegate.expandedRowIndex() {
            expandRowAtIndex(delegate.expandedRowIndex())
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        
        cellContainer.backgroundColor = colorTheme.darkColor
        tapContainer.backgroundColor = UIColor.clearColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(SubmitTimesCollectionViewCell.handleTap(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SubmitTimesCollectionViewCell.handleTap(_:)))
        tapContainer.addGestureRecognizer(tap)
        tapContainer.addGestureRecognizer(pan)
        
        amLabel.text = "AM"
        amLabel.textColor = UIColor.darkBlue()
        amLabel.font = UIFont.graphikRegular(10)
        
        pmLabel.text = "PM"
        pmLabel.textColor = UIColor.darkBlue()
        pmLabel.font = UIFont.graphikRegular(10)
        
        helpLabel.font = UIFont.graphikRegular(14)
        helpLabel.numberOfLines = 0
        helpLabel.lineBreakMode = .ByWordWrapping
        helpLabel.textAlignment = .Center
        
        let times = createTimes()
        
        let expandRowPassiveAlpha:CGFloat = 0.75
        
        expandRow1Button.alpha = expandRowPassiveAlpha
        expandRow1Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow(_:)), forControlEvents: .TouchUpInside)
        expandRow1Button.tag = 1
        
        expandRow2Button.alpha = expandRowPassiveAlpha
        expandRow2Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow(_:)), forControlEvents: .TouchUpInside)
        expandRow2Button.tag = 2
        
        expandRow3Button.alpha = expandRowPassiveAlpha
        expandRow3Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow(_:)), forControlEvents: .TouchUpInside)
        expandRow3Button.tag = 3
        
        expandRow4Button.alpha = expandRowPassiveAlpha
        expandRow4Button.addTarget(self, action: #selector(SubmitTimesCollectionViewCell.toggleRow(_:)), forControlEvents: .TouchUpInside)
        expandRow4Button.tag = 4
        
        row1 = [timeCell0, timeCell1, timeCell2, timeCell3, timeCell4, timeCell5]
        row2 = [timeCell6, timeCell7, timeCell8, timeCell9, timeCell10, timeCell11]
        row3 = [timeCell12, timeCell13, timeCell14, timeCell15, timeCell16, timeCell17]
        row4 = [timeCell18, timeCell19, timeCell20, timeCell21, timeCell22, timeCell23]
        cells = [timeCell0, timeCell1, timeCell2, timeCell3, timeCell4, timeCell5, timeCell6, timeCell7, timeCell8, timeCell9, timeCell10, timeCell11, timeCell12, timeCell13, timeCell14, timeCell15, timeCell16, timeCell17, timeCell18, timeCell19, timeCell20, timeCell21, timeCell22, timeCell23]
        
        addSubview(cellContainer)
        for (index, cell) in cells.enumerate() {
            cell.delegate = self
            cell.baseTime = times[index]
            cell.colorTheme = colorTheme
            cell.state = .closed
            addSubview(cell)
            
            self.times.append(cell.hourCell)
            self.times.append(cell.quarterCell)
            self.times.append(cell.halfCell)
            self.times.append(cell.threeQuartersCell)
        }
        
        addSubview(expandRow1Button)
        addSubview(expandRow2Button)
        addSubview(expandRow3Button)
        addSubview(expandRow4Button)
        addSubview(tapContainer)
        addSubview(amLabel)
        addSubview(pmLabel)
        addSubview(helpLabel)
    }
    
    func applyConstraints() {
        cellContainer.addConstraints(
            Constraint.tt.of(self, offset: 50),
            Constraint.bb.of(timeCell23, offset: 1),
            Constraint.rr.of(self, offset: -timeSelectSize),
            Constraint.w.of((timeSelectSize * 6) + 7)
        )
        
        tapContainer.addConstraints(
            Constraint.ttbb.of(cellContainer),
            Constraint.llrr.of(cellContainer)
        )
        
        // row1
        toggleExpandedRowConstraints(1, expanded: false)
        
        expandRow1Button.addConstraints(
            Constraint.lr.of(timeCell5, offset: 0),
            Constraint.cyt.of(timeCell0, offset: timeSelectSize/2),
            Constraint.wh.of(timeSelectSize)
        )
        
        // row2
        toggleExpandedRowConstraints(2, expanded: false)
        
        expandRow2Button.addConstraints(
            Constraint.cxcx.of(expandRow1Button),
            Constraint.cyt.of(timeCell6, offset: timeSelectSize/2),
            Constraint.wh.of(timeSelectSize)
        )
        
        // row3
        toggleExpandedRowConstraints(3, expanded: false)
        
        expandRow3Button.addConstraints(
            Constraint.cxcx.of(expandRow1Button),
            Constraint.cyt.of(timeCell12, offset: timeSelectSize/2),
            Constraint.wh.of(timeSelectSize)
        )
        
        // row4
        toggleExpandedRowConstraints(4, expanded: false)
        
        expandRow4Button.addConstraints(
            Constraint.cxcx.of(expandRow1Button),
            Constraint.cyt.of(timeCell18, offset: timeSelectSize/2),
            Constraint.wh.of(timeSelectSize)
        )
        
        amLabel.addConstraints(
            Constraint.tt.of(timeCell0, offset: 4),
            Constraint.ll.of(timeCell0, offset: 4)
        )
        
        pmLabel.addConstraints(
            Constraint.tt.of(timeCell12, offset: 4),
            Constraint.ll.of(timeCell12, offset: 4)
        )
        
        helpLabel.addConstraints(
            Constraint.llrr.of(self, offset: 0.2 * screenWidth),
            Constraint.tb.of(timeCell23, offset: 30)
        )
    }
    
    // MARK: Methods
    func updateWithDate(date: NSDate) {
        self.date = date
        
        let times = createTimes()
        
        for (index, cell) in cells.enumerate() {
            cell.baseTime = times[index]
        }
    }
    
    func expandRowAtIndex(rowIndex: Int) {
        if let button = buttonForIndex(rowIndex) {
            toggleRow(button)
        } else {
            toggleRow(toggledButton)
        }
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if initialStates.isEmpty {
            for time in times {
                initialStates.append(time.selectedBackground.alpha)
            }
        }
        
        for (index, cell) in cells.enumerate() {
            if cell.frame.contains(gestureRecognizer.locationInView(self)) {
                
                var timeCell = TimeCell()
                var timeIndex = index * 4
                if cell.hourCell.frame.contains(gestureRecognizer.locationInView(cell)){
                    timeCell = cell.hourCell
                } else if cell.quarterCell.frame.contains(gestureRecognizer.locationInView(cell)){
                    timeCell = cell.quarterCell
                    timeIndex += 1
                } else if cell.halfCell.frame.contains(gestureRecognizer.locationInView(cell)){
                    timeCell = cell.halfCell
                    timeIndex += 2
                } else if cell.threeQuartersCell.frame.contains(gestureRecognizer.locationInView(cell)){
                    timeCell = cell.threeQuartersCell
                    timeIndex += 3
                }
                if timeCell.selectedBackground.alpha  == initialStates[timeIndex] {
                    timeCell.handleTap()
                }
            }
        }
        
        if gestureRecognizer.state == .Ended {
            initialStates.removeAll()
        }
    }
    
    func toggleRow(button: UIButton) {
        var selectedRow = [ExpandingTimeCell]()
        
        if state == .closed {
            // just toggle the row
            selectedRow = rowForIndex(button.tag)
            state = SubmitTimesCollectionViewCellState(rawValue: button.tag)!
            toggleExpandedRowConstraints(button.tag, expanded: true)
            toggledButton = button
            
            UIView.animateWithDuration(0.25) {
                self.layoutIfNeeded()
                self.toggledButton.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2))
                self.toggledButton.alpha = 1.0
            }
            
            for cell in selectedRow {
                cell.toggle()
            }
        } else if button.tag == state.rawValue {
            // close the toggled row
            selectedRow = rowForIndex(button.tag)
            state = .closed
            toggleExpandedRowConstraints(button.tag, expanded: false)
            
            UIView.animateWithDuration(0.25) {
                self.toggledButton.transform = CGAffineTransformIdentity
                self.toggledButton.alpha = 0.75
                self.layoutIfNeeded()
            }
            
            for cell in selectedRow {
                cell.toggle()
            }
        } else {
            // toggle the row and close the already toggled row
            // close the toggled row
            selectedRow = rowForIndex(state.rawValue)
            toggleExpandedRowConstraints(state.rawValue, expanded: false)
            
            for cell in selectedRow {
                cell.toggle()
            }
            
            selectedRow = rowForIndex(button.tag)
            state = SubmitTimesCollectionViewCellState(rawValue: button.tag)!
            toggleExpandedRowConstraints(button.tag, expanded: true)
            
            UIView.animateWithDuration(0.25, animations: { 
                self.toggledButton.transform = CGAffineTransformIdentity
                self.toggledButton.alpha = 0.75
                button.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2))
                button.alpha = 1.0
                self.layoutIfNeeded()
                }, completion: { (finished) in
                    self.toggledButton = button
            })
            
            for cell in selectedRow {
                cell.toggle()
            }
        }
        
        delegate.rowExpanded(state.rawValue)
    }
    
    func expandButtonAction(button: UIButton) {
        
    }
    
    // MARK: ExpandingTimeCellDelegate
    func stateForTime(time: NSDate) -> TimeCellState {
        return delegate.stateForTime(time)
    }
    
    func timeCellStateChanged(newState: TimeCellState, date: NSDate) {
        delegate.timeCellStateChanged(newState, date: date)
    }

    // MARK: Utilities
    
    func createTimes() -> [NSDate]{
        var times = [NSDate]()
        
        for n in 0...23 {
            times.append(createDateWithComponents(date.year(), monthNumber: date.month(), dayNumber: date.day(), hourNumber: n, minuteNumber: 0))
        }
        
        return times
    }
    
    func buttonForIndex(index: Int) -> UIButton? {
        switch index {
        case 1:
            return expandRow1Button
        case 2:
            return expandRow2Button
        case 3:
            return expandRow3Button
        case 4:
            return expandRow4Button
        default:
            return nil
        }
    }
    
    func rowForIndex(index: Int) -> [ExpandingTimeCell] {
        switch index {
        case 1:
            return row1
        case 2:
            return row2
        case 3:
            return row3
        case 4:
            return row4
        default:
            return []
        }
    }
    
    func toggleExpandedRowConstraints(rowIndex: Int, expanded: Bool) {
        var topConstraint: APConstraint!
        var leftConstraint: APConstraint!
        let widthConstraint = Constraint.w.of(timeSelectSize)
        var heightConstraint: APConstraint!
        
        if expanded {
            heightConstraint = Constraint.h.of((timeSelectSize * 4) + 3)
        } else {
            heightConstraint = Constraint.h.of(timeSelectSize)
        }
        
        switch rowIndex {
        case 1:
            topConstraint = Constraint.tt.of(cellContainer, offset: 1)
        case 2:
            topConstraint = Constraint.tb.of(timeCell0, offset: 1)
        case 3:
            topConstraint = Constraint.tb.of(timeCell6, offset: 1)
        case 4:
            topConstraint = Constraint.tb.of(timeCell12, offset: 1)
        default:
            return
        }
        
        let row = rowForIndex(rowIndex)
        var previousCell = ExpandingTimeCell()
        for cell in row {
            if cell == row.first {
                leftConstraint = Constraint.ll.of(cellContainer, offset: 1)
            } else {
                leftConstraint = Constraint.lr.of(previousCell, offset: 1)
            }
            
            cell.addConstraints(
                topConstraint,
                leftConstraint,
                widthConstraint,
                heightConstraint
            )
            
            previousCell = cell
        }
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int, minuteNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = minuteNumber
        components.second = 0
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
}
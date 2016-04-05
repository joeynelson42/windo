//
//  TutorialViewController.swift
//  Windo
//
//  Created by Joey on 4/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    
    var tutorialView = TutorialView()
    
    var red = CGFloat()
    var blue = CGFloat()
    var green = CGFloat()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = tutorialView
        tutorialView.mainScrollView.delegate = self
        addTargets()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addTargets(){
        tutorialView.xButton.addTarget(self, action: #selector(TutorialViewController.dismissTutorial), forControlEvents: .TouchUpInside)
    }
    
    func dismissTutorial(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > (screenWidth * 2) {
            return
        }
        
        let percent = scrollView.contentOffset.x/(screenWidth * 2)
        
        if percent <= 0.5 {
            let tempPercent = percent * 2
            red = tealRed + (tempPercent * (blueRed - tealRed))
            green = tealGreen + (tempPercent * (blueGreen - tealGreen))
            blue = tealBlue + (tempPercent * (blueBlue - tealBlue))
        }
        else {
            let tempPercent = (percent - 0.5) * 2
            red = blueRed + (tempPercent * (purpleRed - blueRed))
            green = blueGreen + (tempPercent * (purpleGreen - blueGreen))
            blue = blueBlue + (tempPercent * (purpleBlue - blueBlue))
        }
        
        let background = UIColor(red:red/256, green:green/256, blue:blue/256, alpha: 1.0)
        tutorialView.mainView.backgroundColor = background
        
        
        let circlesWidth = tutorialView.circles.frame.width - tutorialView.circles.indicatorCircle.frame.width
        tutorialView.circles.indicatorCircle.transform = CGAffineTransformMakeTranslation(percent * circlesWidth, 0)
        
        if percent < 0.5 {
            tutorialView.circles.showFirstConnector()
        }
        else if percent > 0.5 {
            tutorialView.circles.showSecondConnector()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        tutorialView.circles.hideConnectors()
    }
}

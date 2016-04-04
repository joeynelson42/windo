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
    
    let tealRed:CGFloat = 13
    let tealGreen:CGFloat = 178
    let tealBlue:CGFloat = 177
    
    let blueRed:CGFloat = 71
    let blueGreen:CGFloat = 96
    let blueBlue:CGFloat = 235
    
    let purpleRed:CGFloat = 158
    let purpleGreen:CGFloat = 101
    let purpleBlue:CGFloat = 201
    
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
    }
}

//
//  SideMenuViewController.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func pageSelected(pageIndex: Int)
}

class SidePanelViewController: UIViewController {
    
    var delegate: SidePanelViewControllerDelegate?
    var sideMenuView = SideMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkTeal()
        sideMenuView = SideMenuView(frame: self.view.frame)
        view.addSubview(sideMenuView)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func handleNavigate(sender: UIButton){
        delegate?.pageSelected(sender.tag)
    }
}


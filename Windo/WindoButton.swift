//
//  WindoButton.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum WindoButtonState{
    case Unselected
    case SelectedOnce
    case SelectedTwice
}

class WindoButton: UIButton {
    
    //MARK: Properties
    var backgroundView = UIView()
    var buttonState = WindoButtonState.Unselected
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        
    }
    
    func applyConstraints(){
        
    }
    
    func advanceState(){
        switch buttonState{
        case .Unselected:
            buttonState = .SelectedOnce
        case .SelectedOnce:
            buttonState = .SelectedTwice
        case .SelectedTwice:
            buttonState = .Unselected
        }
        
        
    }
    

}

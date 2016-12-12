//
//  UserProfileViewController.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    //MARK: Properties
    
    var profileView: UserProfileView!
    var color = ThemeColor.teal
    var user = UserProfile()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        profileView = UserProfileView(color: color)
        view = profileView
        profileView.profileImage.setupView(user, width: 150)
        profileView.nameLabel.text = user.fullName
    }
}

//
//  WindoProfileImageView.swift
//  Windo
//
//  Created by Joey on 6/17/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoProfileImageView: UIView {
    
    //MARK: Properties
    var user: UserProfile!
    var width: CGFloat!
    var image: UIImage!
    
    var imageView = UIImageView()
    var initals = UILabel()
    
    //MARK: Inits
    convenience init(width: CGFloat, userProfile: UserProfile, fetchImage: Bool = true) {
        self.init(frame: CGRectZero)
        self.user = userProfile
        self.width = width
        
        if fetchImage {
            self.fetchProfileImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        layer.cornerRadius = width/2
        clipsToBounds = true
        
        imageView.contentMode = .ScaleAspectFill
        
        initals.text = user.getInitials()
        initals.font = UIFont.graphikRegular(width/2)
        initals.textAlignment = .Center
        
        addSubview(initals)
        addSubview(imageView)
    }
    
    func applyConstraints(){
        initals.addConstraints(
            Constraint.llrr.of(self),
            Constraint.ttbb.of(self)
        )
        
        imageView.addConstraints(
            Constraint.llrr.of(self),
            Constraint.ttbb.of(self)
        )
    }
    
    func fetchProfileImage() {
        if user.profilePictureURL == "" {
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: user.profilePictureURL)!, completionHandler: { (data, response, error) -> Void in
            guard let imageData = data else { return }
            
            dispatch_async(dispatch_get_main_queue(), { Void in
                self.imageView.image = UIImage(data: imageData)
            });
            
        }).resume()
    }
}
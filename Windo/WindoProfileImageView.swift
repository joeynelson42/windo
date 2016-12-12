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
    fileprivate var cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
    fileprivate var blurRadius: CGFloat?
    fileprivate var urlString: String?
    fileprivate var request: NSMutableURLRequest?
    fileprivate var task: URLSessionDataTask?
    
    var imageView = UIImageView()
    var initals = UILabel()
    
    //MARK: Inits
//    convenience init(width: CGFloat, userProfile: UserProfile, fetchImage: Bool = true) {
//        self.init(frame: CGRectZero)
//        self.user = userProfile
//        self.width = width
//        
//        if fetchImage {
//            self.fetchProfileImage()
//        }
//    }
    
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
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        initals.textAlignment = .center
        
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
    
    func setupView(_ user: UserProfile, width: CGFloat, withCachePolicy cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad, blurRadius: CGFloat? = nil) {
        // Don't bother reloading if the url isn't changing, unless the cache policy reqeusts it
        if user.profilePictureURL == self.urlString &&
            cachePolicy != .reloadIgnoringCacheData &&
            cachePolicy != .reloadIgnoringLocalCacheData &&
            cachePolicy != .reloadIgnoringLocalAndRemoteCacheData {
            return
        }
        // Note: Image access must occur on main queue
        initals.text = user.getInitials()
        layer.cornerRadius = width/2
        initals.font = UIFont.graphikRegular(width/2)
//        self.placeholderView.alpha = 1
        
        
        self.urlString = user.profilePictureURL
        self.cachePolicy = cachePolicy
        self.blurRadius = blurRadius
        // Cancel any in-progress image downloads
        self.task?.cancel()
        // Execute current download
        self.executeQuery()
    }
    
    
    /// Attempts to download an image from the given URL, and displays it once the download has completed.
    /// This must be called from the background queue.
    fileprivate func executeQuery() {
//        guard let urlString = self.urlString else {
//            return
//        }
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        // Only need to initialize request once; afterwards we just reset the URL and task object
//        if self.request == nil {
//            self.request = NSMutableURLRequest(url: url)
//            self.request!.cachePolicy = self.cachePolicy
//        } else {
//            self.request!.url = url
//        }
//        self.task = URLSession.shared.dataTask(with: self.request!, completionHandler: { (data, response, error) in
//            guard error == nil else {
//                return
//            }
//            guard let imageData = data else {
//                return
//            }
//            guard let image = UIImage(data: imageData) else {
//                return
//            }
//            // Blur image if requested
////            let outputImage = image.blurredImageWithRadius(self.blurRadius)
//            // Display image on main queue
//            DispatchQueue.main.async {
//                
//                // Animate the placeholder view away
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.imageView.image = image
////                    self.placeholderView.alpha = 0
//                }) 
//            }
//        })
//        self.task?.resume()
    }
}

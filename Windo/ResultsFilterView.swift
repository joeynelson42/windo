//
//  ResultsFilterCell.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ResultsFilterView: UIView {
    
    //MARK: Properties
    var filterCollectionView: UICollectionView!
    var collectionViewAdded = false
    
    var members = [String]()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightPurple()
        
        configureCollectionView()
    }
    
    func applyConstraints(){
        filterCollectionView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
    }
}

extension ResultsFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        if collectionViewAdded {
            return
        }
        collectionViewAdded = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        filterCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(ResponseCell.self, forCellWithReuseIdentifier: "responseCell")
        filterCollectionView.showsVerticalScrollIndicator = false
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.backgroundColor = UIColor.clear
        addSubview(filterCollectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "responseCell", for: indexPath) as! ResponseCell
        cell.alpha = 0.5
        cell.layer.cornerRadius = 20
        cell.initials.text = members[(indexPath as NSIndexPath).row].getInitials()
        
        if members[(indexPath as NSIndexPath).row] == "John Jackson" {
            cell.imageView.image = UIImage(named: "John Profile")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ResponseCell!
        
        if cell?.alpha == 0.5 {
            UIView.animate(withDuration: 0.2, animations: {
                cell?.alpha = 1.0
            })
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                cell?.alpha = 0.5
            })
        }
        
    }
}

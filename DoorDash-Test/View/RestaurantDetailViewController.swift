//
//  RestaurantDetailViewController.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/12/21.
//

import Foundation
import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var lastScrollingOffset: CGFloat = 0.0
    var maxHeaderHeight: CGFloat = 300.0
    var minHeaderHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
//        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        maxHeaderHeight = headerViewHeightConstraint.constant
//        minHeaderHeight = 10.0
    }
}

// MARK: CollectionView DataSource
extension RestaurantDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

//extension RestaurantDetailViewController: UICollectionViewDelegate {
//    
//}

// MARK: ScrollView Delegate
extension RestaurantDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let difference = scrollView.contentOffset.y - lastScrollingOffset
        if headerViewHeightConstraint.constant > maxHeaderHeight {
            headerViewHeightConstraint.constant = maxHeaderHeight
        } else {
            headerViewHeightConstraint.constant = headerViewHeightConstraint.constant - difference
        }
        
        lastScrollingOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
          let  midValue =  self.maxHeaderHeight / 2  // half range value of maxheight
          UIView.animate(withDuration: 0.2) {
              // if current height of headeview is greated than mid value. Set minHeight as a height of  headerview else Set maxHeight as a height of  headerview
              if midValue > self.headerViewHeightConstraint.constant {
                  self.headerViewHeightConstraint.constant = self.minHeaderHeight
              } else {
                  self.headerViewHeightConstraint.constant = self.maxHeaderHeight
              }
              self.view.layoutIfNeeded()
          }
          
      }
}

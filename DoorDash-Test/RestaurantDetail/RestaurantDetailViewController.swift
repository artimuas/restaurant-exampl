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
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    private var lastScrollingOffset: CGFloat = 0.0
    private var maxHeaderHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
//        collectionView.delegate = self
        maxHeaderHeight = headerHeightConstraint.constant
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
        
        let y = maxHeaderHeight - (scrollView.contentOffset.y + maxHeaderHeight)
        let height = min(max(150, y), 400)
        headerHeightConstraint.constant = height
        view.layoutIfNeeded()
    }
}

//
//  RestaurantListViewCell.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/11/21.
//

import Foundation
import UIKit

typealias RestaurantSelectionAction = (Restaurant)->()

class RestaurantListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cuisinesLabels: UILabel!
    
    var action: Action?
    
    func configure(withViewModel viewModel: RestaurantListCellViewModel, action: RestaurantSelectionAction?) {
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        cuisinesLabels.text = viewModel.cuisines
        self.action = action
    }
}

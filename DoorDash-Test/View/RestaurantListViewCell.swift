//
//  RestaurantListViewCell.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/11/21.
//

import Foundation
import UIKit

class RestaurantListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cuisinesLabels: UILabel!
    
    func configure(withViewModel viewModel: RestaurantCellViewModel) {
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        cuisinesLabels.text = viewModel.cuisines
    }
}

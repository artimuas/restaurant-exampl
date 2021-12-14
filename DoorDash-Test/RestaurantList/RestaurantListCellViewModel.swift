//
//  RestaurantViewCellViewModel.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/11/21.
//

import Foundation

struct RestaurantListCellViewModel {
//    private let restaurant: Restaurant
    
    let name: String
    let address: String
    let cuisines: String
    
    init(_ restaurant: Restaurant) {
        self.name = restaurant.name
        self.address = ("\(restaurant.address.formatted), \(restaurant.address.state), \(restaurant.address.postal_code).")
        self.cuisines = restaurant.cuisines.joined(separator: ", ")
    }
}

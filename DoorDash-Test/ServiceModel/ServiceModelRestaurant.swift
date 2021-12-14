//
//  ServiceModelRestaurant.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/10/21.
//

import Foundation

struct ServiceModelRestaurantMeta: Decodable {
    let data: [ServiceModelRestaurant]
    let more_pages: Bool
    let numResults: Int
    let totalResults: Int
    let total_pages: Int
    
    struct ServiceModelRestaurant: Decodable {
        let address: ServiceModelAddress
        let cuisines: [String]
        let geo: ServiceModelCoordinates
        let hours: String
        let last_updated: String
        let price_range: String
        let restaurant_id: Int
        let restaurant_name: String
        let restaurant_phone: String
        let restaurant_website: String
        let menus: [ServiceModelMenu]
        
        struct ServiceModelAddress: Decodable {
            let city: String
            let formatted: String
            let postal_code: String
            let state: String
            let street: String
        }

        struct ServiceModelCoordinates: Decodable {
            let lat: Double
            let lon: Double
        }
        
        struct ServiceModelMenu: Decodable {
            let menu_name: String
            let menu_sections: [ServiceModelMenuSection]
            
            struct ServiceModelMenuSection: Decodable {
                let section_name: String
                let description: String
                let menu_items: [ServiceModelRestaurantMenuItem]
            }
            
            struct ServiceModelRestaurantMenuItem: Decodable {
                let name: String
                let description: String
                let price: Double
                let pricing: ServiceModelRestaurantMenuItemPricing
            }
            
            struct ServiceModelRestaurantMenuItemPricing: Decodable {
                let price: Double
                let currency: String
                let priceString: String
            }
        }
    }
}


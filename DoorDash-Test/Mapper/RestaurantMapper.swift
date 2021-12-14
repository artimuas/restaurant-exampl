//
//  RestaurantMapper.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/10/21.
//

import Foundation

struct RestaurantMapper {
    func transform(_ serviceModel: [ServiceModelRestaurantMeta.ServiceModelRestaurant]) -> [Restaurant]? {
        var restaurants: [Restaurant]
        
        restaurants = serviceModel.map { serviceRestaurant in
            return Restaurant(address: Restaurant.RestaurantAddress(city: serviceRestaurant.address.city,
                                                                    formatted: serviceRestaurant.address.formatted,
                                                                    postal_code: serviceRestaurant.address.postal_code,
                                                                    state: serviceRestaurant.address.state,
                                                                    street: serviceRestaurant.address.street),
                              cuisines: serviceRestaurant.cuisines,
                              geo: Restaurant.RestaurantCoordinates(lat: serviceRestaurant.geo.lat,
                                                                    lon: serviceRestaurant.geo.lon),
                              hours: serviceRestaurant.hours,
                              lastUpdated: serviceRestaurant.last_updated,
                              priceRange: serviceRestaurant.price_range,
                              id: serviceRestaurant.restaurant_id,
                              name: serviceRestaurant.restaurant_name,
                              phone: serviceRestaurant.restaurant_phone,
                              website: serviceRestaurant.restaurant_website)
        }
        
        return restaurants
    }
    
}

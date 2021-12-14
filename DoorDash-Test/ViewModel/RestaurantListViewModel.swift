//
//  RestaurantListViewModel.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/11/21.
//

import Foundation
import Combine
import CoreLocation

enum ViewModelError: Error {
    case fetching(String)
    case service(String)
}

enum Location {
    case current
    case coordinates(CLLocationCoordinate2D)
}

class RestaurantListViewModel {
    var restaurants = [Restaurant]()
    
    var service = RestaurantService()
    let mapper = RestaurantMapper()
    
    func fetchRestaurants(forLocation location: Location, completion: @escaping (Result<[Restaurant], ViewModelError>) -> Void) {
        service.getRestaurants(atLat: 40.68919, lon: -73.992378, distance: 10) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let restaurants = self.mapper.transform(data) else {
                    completion(.failure(.fetching("Failed to fetch restaurants.")))
                    return
                }
                self.restaurants = restaurants
                completion(.success(restaurants))
            case .failure(let error):
                completion(.failure(.service(error.localizedDescription)))
            }
        }
    }
    
    func itemViewModel(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModel? {
        guard 0..<restaurants.count ~= indexPath.row else { return nil }
        return RestaurantCellViewModel(restaurant: restaurants[indexPath.row])
    }
}

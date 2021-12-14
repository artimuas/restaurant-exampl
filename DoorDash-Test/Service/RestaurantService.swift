//
//  RestaurantService.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/9/21.
//

import Foundation
import UIKit

struct RestaurantTarget: Hashable {
    private static let apiKey = "{API_KEY}"
    
    private static let host = "https://api.documenu.com/v2"
    
    private static let path = "restaurants/search/geo"
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var distance: Double = 0.0
    
    private var parameters: [String: Double] {
        ["lat": latitude,
         "lon": longitude,
         "distance": distance]
    }
    
    private let headers = [
        "x-api-key": Self.apiKey,
        "x-rapidapi-host": "documenu.p.rapidapi.com",
        "x-rapidapi-key": "{RAPID_API_KEY}"
    ]
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: "\(Self.host)/\(Self.path)")
        components?.queryItems = parameters.map{ (key, value) in
            URLQueryItem(name: key, value: String(value))
        }
        var request = URLRequest(url: (components?.url)!)
        request.allHTTPHeaderFields = headers
        return request
    }
}

class RestaurantService {
    typealias ServiceModel = ServiceModelRestaurantMeta.ServiceModelRestaurant
    
    private var target = RestaurantTarget()
    private var cache = Cache()
    
    private func fetchFromNetwork(_ completion: @escaping (Result<[RestaurantService.ServiceModel], RestaurantServiceError>) -> Void) {
        
    }
        
    func getRestaurants(atLat lat: Double,
                                 lon: Double,
                                 distance: Double,
                                 completion: @escaping (Result<[ServiceModel], RestaurantServiceError>) -> Void) {
        target.latitude = lat
        target.longitude = lon
        target.distance = distance
        
        if let cachedData = cache[target.hashValue] {
            let restaurantData = try! JSONDecoder().decode(ServiceModelRestaurantMeta.self, from: cachedData)
            completion(.success(restaurantData.data))
        } else {
            URLSession.shared.dataTask(with: target.urlRequest) { [weak self] (data, response, error) in
                guard let self = self,
                        let data = data,
                        error == nil else {
                    completion(
                        .failure(
                            .service(error?.localizedDescription ?? "Network Error occured")
                        )
                    )
                    return
                }
                
                self.cache[self.target.hashValue] = data
                
                do {
                    let restaurantData = try JSONDecoder().decode(ServiceModelRestaurantMeta.self, from: data)
                    completion(.success(restaurantData.data))
                } catch _ {
                    completion(.failure(.decoding("Decoding failed")))
                }
            }.resume()
        }
    }
}

enum RestaurantServiceError: Error {
    case service(String)
    case decoding(String)
}

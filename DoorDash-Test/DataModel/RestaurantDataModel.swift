import Foundation

struct Restaurant {
    let address: RestaurantAddress
    let cuisines: [String]
    let geo: RestaurantCoordinates
    let hours: String
    let lastUpdated: String
    let priceRange: String
    let id: Int
    let name: String
    let phone: String
    let website: String
    
    
    struct RestaurantAddress {
        let city: String
        let formatted: String
        let postal_code: String
        let state: String
        let street: String
    }

    struct RestaurantCoordinates {
        let lat: Double
        let lon: Double
    }
}

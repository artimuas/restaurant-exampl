//
//  RestaurantCache.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/11/21.
//

import Foundation

struct CacheItem {
    let data: Data?
    let timeStamp = Date()
}

struct Cache {
    var timeToLive: TimeInterval = 180
    
    private func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to get a handle to documents directory.")
        }
    }
    
    private func save(_ data: Data?, forKey key: AnyHashable) {
        guard let data = data else { return }
        let docsURL = getDocumentsURL().appendingPathComponent(String(key.hashValue))
        do {
            try data.write(to: docsURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func retrieve(dataFor key: AnyHashable) -> Data? {
        let docsURL = getDocumentsURL().appendingPathComponent(String(key.hashValue))
        do {
            let data = try Data(contentsOf: docsURL)
            return data
        } catch {
            return nil
        }
    }
    
    private func purge() {
        
    }
    
    private func remove(dataFor key: String) -> Data? {
        nil
    }
    
    subscript(key: AnyHashable) -> Data? {
        set {
            save(newValue, forKey: key)
        }
        get {
            return retrieve(dataFor: key)
        }
    }
}

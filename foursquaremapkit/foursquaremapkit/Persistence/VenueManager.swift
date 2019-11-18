//
//  RestaurantDataManager.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

final class VenueManager {
    private init() {}
    
    static private var favoriteRestaurants = [FaveRestaurant]()
    
    static public func fetchFavoriteFromDocumentsDirectory(collection: String) -> [FaveRestaurant] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: "\(collection).plist").path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    favoriteRestaurants = try PropertyListDecoder().decode([FaveRestaurant].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("nil data")
            }
        } else {
            print("filename \(collection) does not exist")
        }
        return favoriteRestaurants
    }

    static public func save(collection: String) {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: collection)
        do {
            let data = try PropertyListEncoder().encode(favoriteRestaurants)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    
    static public func addVenue(newFavoriteRestaurant: FaveRestaurant, collection: String) {
        favoriteRestaurants.removeAll()
        favoriteRestaurants = fetchFavoriteFromDocumentsDirectory(collection: collection)
        favoriteRestaurants.append(newFavoriteRestaurant)
        save(collection: collection)
    }
    
    static public func deleteVenue(atIndex: Int, collection: String) {
        favoriteRestaurants = fetchFavoriteFromDocumentsDirectory(collection: collection)
        favoriteRestaurants.remove(at: atIndex)
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: "\(collection).plist")
        do {
            let data = try PropertyListEncoder().encode(favoriteRestaurants)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }

    }
}

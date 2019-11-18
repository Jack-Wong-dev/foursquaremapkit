//
//  Favorite.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct FaveRestaurant: Codable {
    let collectionName: String
    let restaurantName: String
    let imageData: Data?
    let venueTip: String?
    let description: String
    let address: String
}

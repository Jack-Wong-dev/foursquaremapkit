//
//  Photo.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation


struct PhotoModel: Codable {
    let response: ResponseWrapper
}

struct ResponseWrapper: Codable {
    let photos: PhotoWrap
}

struct PhotoWrap: Codable {
    let items: [ItemWrapper]
}

struct ItemWrapper: Codable {
    let prefix: String
    let suffix: String
}

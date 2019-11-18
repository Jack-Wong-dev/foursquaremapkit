//
//  Search.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//
import Foundation

struct FourSquareModel: Codable {
    let response: ResponseWrap
}

struct ResponseWrap: Codable {
    let venues: [VenueStruct]
}
struct VenueStruct: Codable {
    var imageLink: String?
    let id: String
    let name: String
    let location: LocationWrapper
    let categories: [CategoryWrapper]
}
struct LocationWrapper: Codable {
    let address: String?
    let lat: Double?
    let lng: Double?
    let labeledLatLngs: [LLWrapper]
    let formattedAddress: [String]
    var modifiedAddress: String {
        let address = """
        
        \(formattedAddress[0]),
        \(formattedAddress[1]),
        \(formattedAddress[2])
        """
        
        return address
    }
}
struct LLWrapper: Codable {
    let label: String
    let lat: Double
    let lng: Double
}

struct CategoryWrapper: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: IconWrapper
}

struct IconWrapper: Codable {
    let prefix: String
    let suffix: String
}

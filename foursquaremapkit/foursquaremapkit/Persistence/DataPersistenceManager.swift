//
//  DataPersistenceManager.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/11/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//
import Foundation

final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}



//
//  AppError.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/11/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

enum AppError: Error {
  case badURL(String)
  case jsonDecodingError(Error)
  case networkError(Error)
  case badStatusCode(String)
  case propertyListEncodingError(Error)
}

extension AppError{
    public func errorMessage() -> String {
      switch self {
          case .badURL(let errorResult):
            return "bad url: \(errorResult)"
          case .jsonDecodingError(let error):
            return "json decoding error: \(error)"
          case .networkError(let error):
            return "network error: \(error)"
          case .badStatusCode(let message):
            return "bad status code: \(message)"
          case .propertyListEncodingError(let error):
            return "property list encoding error: \(error)"
      }
    }
}

import Foundation

final class FourSquareAPIClient {
    static func getVenue(latitude: String, longitude: String, category: String, completionHandler: @escaping(AppError?, [VenueStruct]?) -> Void) {
        
        let URL = "https://api.foursquare.com/v2/venues/search?client_id=\(APIKeys.clientID)&client_secret=\(APIKeys.clientSecret)&v=20180323&ll=\(latitude),\(longitude)&query=\(category)"
        
        
        NetworkHelper.shared.performDataTask(endpointURLString: URL, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let error = appError {
                completionHandler(error, nil)
            }
            if let data = data {
                do {
                    let venueInfo = try
                        JSONDecoder().decode(FourSquareModel.self, from: data)
                    completionHandler(nil, venueInfo.response.venues)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
    static func getImages(venueID: String, completionHandler: @escaping ((AppError?, String?) -> Void)) {

        let URL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(APIKeys.clientID)&client_secret=\(APIKeys.clientSecret)&v=20191115"

        
        NetworkHelper.shared.performDataTask(endpointURLString: URL, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let error = appError {
                completionHandler(error, nil)
            }
            if let data = data {
                do {
                    let imageLinkData = try JSONDecoder().decode(PhotoModel.self, from: data)
                    if let safeImage = imageLinkData.response.photos.items.first {
                    let imageLink = safeImage.prefix + "300x500" + safeImage.suffix
                        completionHandler(nil, imageLink)
                    }
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
}



//
//  Pixabay.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//


import UIKit
import Reachability

struct Hit: Codable {
    let id: Int?
    let largeImageURL: URL
    let previewURL: URL
}

struct PixabaySearchResult: Codable {
    let hits: [Hit]
}

class WebserviceManager {
    private let baseURL = "https://pixabay.com/api/"
    var shouldMock: Bool? = false

    func search(_ searchQuery: String, completionHandler: @escaping (Result<[PixabayImage], ImageSearchError>) -> Void) {

        guard shouldMock == false else {
            let pixabaySearchResult = MockManager.stubPixabayApiResponse()
            let photos: [PixabayImage] = pixabaySearchResult?.hits.compactMap() { hit in
                return PixabayImage(_id: hit.id ?? 0, thumbnailURLString: hit.previewURL.absoluteString, largeImageURLString: hit.largeImageURL.absoluteString)
            } ?? []
            completionHandler(.success(photos))
            return
        }
        
        // escape the query
        let escapedQuery = searchQuery.replacingOccurrences(of: " ", with: "+")
                                      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // build the request
        var requestURL = URLComponents(string: baseURL)!
        requestURL.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: escapedQuery),
            URLQueryItem(name: "safesearch", value: "true"),
            URLQueryItem(name: "per_page", value: "200")
        ]
        
        guard let url = requestURL.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                // cocoa error (network failure, etc.)
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(error)))
                }
                return
            }
            
            guard response != nil else {
                // empty response
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknownResponse))
                }
                return
            }
            
            guard let data = data else {
                // empty data
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknownResponse))
                }
                return
            }

            guard let hits = try? JSONDecoder().decode(PixabaySearchResult.self, from: data).hits else {
                // failed to decode response
                DispatchQueue.main.async {
                    completionHandler(.failure(.decodingError))
                }
                return
            }
            
            // build array of photos
            let photos: [PixabayImage] = hits.compactMap() { hit in
                return PixabayImage(_id: hit.id ?? 0, thumbnailURLString: hit.previewURL.absoluteString, largeImageURLString: hit.largeImageURL.absoluteString)
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(photos))
            }
        }
        task.resume()
    }
}

// TODO: Flesh out errors
enum ImageSearchError: Error {
    case error(Error), unknownResponse, decodingError
}

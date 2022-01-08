//
//  Mocker.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import Foundation

/* MockManager
 This is used for mocking objects of different classes
 */
final class MockManager {
    static func stubPixabayApiResponse(with filename: String = "pixabayApi") -> PixabaySearchResult?  {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                 
                let object = try decoder.decode(PixabaySearchResult.self, from: data)
                return object
                
            } else {
                print("🔴 LOG : Class: \(self) Function: \(#function), Error: No File")
            }
        } catch {
            print("🔴 LOG : Class: \(self) Function: \(#function), Error: \(error.localizedDescription)")
        }
        return nil
    }
}

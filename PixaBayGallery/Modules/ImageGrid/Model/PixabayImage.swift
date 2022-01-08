//
//  PixabayPhoto.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 13/12/2021.
//

import UIKit

struct PixabayImage: Codable {
    let _id: Int
    var thumbnailURLString = "defaultImage"
    var largeImageURLString = "defaultImage"
    init(_id: Int, thumbnailURLString: String, largeImageURLString: String) {
        self._id = _id
        self.thumbnailURLString = thumbnailURLString
        self.largeImageURLString = largeImageURLString
    }
}

extension PixabayImage {
    var thumbnailURL: URL? {
        get {
            return URL(string: thumbnailURLString)
        }
    }
    var largeImageURL: URL? {
        get {
            return URL(string: largeImageURLString)
        }
    }
}

extension PixabayImage: Equatable {
    
}

//
//  ImageDetailViewModel.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import Foundation

class LargePhotoViewModel {
    var largeImageURL: URL?
}

extension LargePhotoViewModel: Equatable {
    static func == (lhs: LargePhotoViewModel, rhs: LargePhotoViewModel) -> Bool {
        return  lhs.largeImageURL == rhs.largeImageURL
    }
}

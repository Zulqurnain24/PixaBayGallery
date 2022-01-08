//
//  PhotoCollectionViewModel.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 13/12/2021.
//

import Foundation
import UIKit

class PhotoCollectionViewModel {
    
    var webserviceManager = WebserviceManager()
    var imageList = [PixabayImage]() {
        didSet {
            guard imageList.count > 0 else { return }
            saveFiles()
            refreshCompletionHandler?()
        }
    }
    
    var refreshCompletionHandler: (() -> Void)? = nil

    init(imageList: [PixabayImage]) {
        self.imageList = imageList
    }
    
    func saveFiles() {
        PersistentStoreManager.shared.setObject(uniqueId: StringConstants.images.rawValue, key: StringConstants.images.rawValue, value: imageList)
    }
    
    func populateFilesFromPersistenceStorage() {
        guard let savedFileList = PersistentStoreManager.shared.getObject(uniqueId: StringConstants.images.rawValue, StringConstants.images.rawValue, [PixabayImage].self)
        else { return }

        self.imageList = savedFileList
    }
    
    func populateDataFromPersistenceStorage() {
        self.populateFilesFromPersistenceStorage()
        self.refreshCompletionHandler?()
    }
    
    func fetchSearchResultsList(searchString: String, _ successCompletionHandler:(() -> Void)? = nil, _ failureCompletionHandler:(() -> Void)? = nil) {
        webserviceManager.search(searchString, completionHandler: { [weak self] result  in
            switch result {
            case .success(let pixaBayImages):
                self?.imageList = pixaBayImages
                self?.refreshCompletionHandler?()
                successCompletionHandler?()
            case .failure(let error):
                print("\(StringConstants.error.rawValue): \(error.localizedDescription)")
                failureCompletionHandler?()
            }
        })
    }
    
}

extension PhotoCollectionViewModel: Equatable {
    static func == (lhs: PhotoCollectionViewModel, rhs: PhotoCollectionViewModel) -> Bool {
        
        let largeImagesUrls = zip(lhs.imageList, rhs.imageList).enumerated().filter() {
            $1.0.thumbnailURL == $1.1.thumbnailURL
        }.map{$0.0}
        
        let thumbnailsUrls = zip(lhs.imageList, rhs.imageList).enumerated().filter() {
            $1.0.largeImageURL == $1.1.largeImageURL
        }.map{$0.0}
        
        return  !largeImagesUrls.isEmpty
                ||
                !thumbnailsUrls.isEmpty
    }
}

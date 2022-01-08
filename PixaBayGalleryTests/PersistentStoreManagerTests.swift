//
//  PersistentStoreManagerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import UIKit
import XCTest
@testable import PixaBayGallery

class PersistentStoreManagerTests: XCTestCase {
    
    var sut: PersistentStoreManager!
    var image: PixabayImage!
    
    override func setUp() {
        super.setUp()
        sut = PersistentStoreManager.shared
        sut.clearData(uniqueId: "0", StringConstants.images.rawValue)
        image = PixabayImage(_id: 0, thumbnailURLString: "https://pixabay.com/photos/thuja-summer-drops-water-plant-4361821/", largeImageURLString: "https://pixabay.com/photos/thuja-summer-drops-water-plant-4361821/")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPersistentStorage() {
        let imagesList = [image]
        sut.setObject(uniqueId: StringConstants.images.rawValue, key: StringConstants.images.rawValue, value: imagesList)
        let storedImagesList = PersistentStoreManager.shared.getObject(uniqueId: StringConstants.images.rawValue, StringConstants.images.rawValue, [PixabayImage].self)
        
        XCTAssertEqual(imagesList.count, storedImagesList?.count)
        XCTAssertEqual(imagesList.first, storedImagesList?.first)
    }
}

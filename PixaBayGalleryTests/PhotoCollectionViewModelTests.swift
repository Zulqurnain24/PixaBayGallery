//
//  PhotoCollectionViewModelTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import XCTest
@testable import PixaBayGallery

class PhotoCollectionViewModelTests: XCTestCase {

    var sut: PhotoCollectionViewModel!
    var image1: PixabayImage!
    var image2: PixabayImage!
    var webserviceManager: WebserviceManager!
    
    override func setUpWithError() throws {
        image1 = PixabayImage(_id: 0, thumbnailURLString: "https://pixabay.com/photos/thuja-summer-drops-water-plant-4361821/", largeImageURLString: "https://pixabay.com/photos/thuja-summer-drops-water-plant-4361821/")
        image2 = PixabayImage(_id: 1, thumbnailURLString: "https://cdn.pixabay.com/photo/2016/09/18/20/25/candy-1678933_1280.jpg", largeImageURLString: "https://cdn.pixabay.com/photo/2016/09/18/20/25/candy-1678933_1280.jpg")
        sut = PhotoCollectionViewModel(imageList: [image1])
        sut.webserviceManager.shouldMock = true
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testImageListCount() throws {
        XCTAssertEqual(sut.imageList.count, 1)
    }

    func testImageListUpdate() throws {
        sut.imageList = []
        XCTAssertEqual(sut.imageList.count, 0)
    }
    
    func testSaveFiles() {
        sut.imageList.append(image2)
        sut.saveFiles()
        sut.populateFilesFromPersistenceStorage()
        
        XCTAssertEqual(sut.imageList.count, 2)
        XCTAssertEqual(sut.imageList.last, image2)
    }
    
    func testEquatable() {
        let sut2 = PhotoCollectionViewModel(imageList: [])
        
        XCTAssertTrue(sut != sut2)
    }
    
    func testFetchSearchResultsList() {
        let expectation = self.expectation(description: #function)
        sut.fetchSearchResultsList(searchString: "flower",  {
            XCTAssertFalse(self.sut.imageList.isEmpty)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5)
    }
}

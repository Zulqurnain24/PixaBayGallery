//
//  ProductGalleryViewControllerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import XCTest
@testable import PixaBayGallery

class PhotoCollectionViewControllerTests: XCTestCase {

    var sut: PhotoCollectionViewController!
    
    override func setUpWithError() throws {
        sut = PhotoCollectionViewController().stub()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testPhotoCollectionViewModelInit() {
        XCTAssertNotNil(sut.photoCollectionViewModel.refreshCompletionHandler)
        XCTAssertNotNil(sut.photoCollectionViewModel.imageList)
        XCTAssertEqual(sut.photoCollectionViewModel.imageList.count, 0)
    }
    
    func testVisibleCellsOnCollectionView() {
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func testSearchResults() {
        sut.searchBar.text = "Flower"
        sut.searchBarSearchButtonClicked(UISearchBar())
        XCTAssertEqual(self.sut.photoCollectionViewModel.imageList.count, 20)
        XCTAssertEqual(self.sut.searchDescriptionImage.isHidden, true)
        XCTAssertEqual(self.sut.searchBar.isFirstResponder, false)
    }

}

//
//  LargePhotoViewModelTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import XCTest
@testable import PixaBayGallery

class LargePhotoViewModelTests: XCTestCase {

    var sut: LargePhotoViewModel!
    
    override func setUpWithError() throws {
        sut = LargePhotoViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInit() {
        sut.largeImageURL = URL(string: "https://pixabay.com/get/g74f5153cbedd2f7a01f43e71cf17df762f3ca3afb819cf3ee48e6d6062cd6c89218fabcfea6e721cd11d22a7c901339fe91a0f32619404e31b60b1b5876ab7c4_1280.jpg")
        XCTAssertEqual(sut.largeImageURL, URL(string: "https://pixabay.com/get/g74f5153cbedd2f7a01f43e71cf17df762f3ca3afb819cf3ee48e6d6062cd6c89218fabcfea6e721cd11d22a7c901339fe91a0f32619404e31b60b1b5876ab7c4_1280.jpg"))
    }
}

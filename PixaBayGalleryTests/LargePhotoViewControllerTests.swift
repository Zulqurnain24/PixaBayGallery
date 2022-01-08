//
//  LargePhotoViewControllerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import Photos
import XCTest
@testable import PixaBayGallery

class LargePhotoViewControllerTests: XCTestCase {

    var sut: LargePhotoViewController!
    
    override func setUpWithError() throws {
        sut = LargePhotoViewController().stub()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInit() throws {
        XCTAssertNotNil(sut.largePhotoViewModel.largeImageURL)
    }

    func testSaveActionForSavePermission() {
        sut.authStatus = PHAuthorizationStatus.authorized
        sut.saveAction(UIBarButtonItem())
        XCTAssertEqual(sut.imageSavedToGallery, true)
    }
    
    func testSaveActionForSavePermissionNotGranted() {
        sut.authStatus = PHAuthorizationStatus.notDetermined
        sut.saveAction(UIBarButtonItem())
        XCTAssertEqual(sut.imageSavedToGallery, false)
    }

    func testSaveActionForSavePermissionForDeniedAndOtherStatuses() {
        sut.authStatus = PHAuthorizationStatus.denied
        sut.saveAction(UIBarButtonItem())
        XCTAssertEqual(sut.imageSavedToGallery, false)
    }
}

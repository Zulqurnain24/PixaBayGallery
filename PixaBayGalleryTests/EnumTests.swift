//
//  PixaBayGalleryTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import XCTest
@testable import PixaBayGallery

class EnumTests: XCTestCase {

    func testExample() throws {
        
        XCTAssertEqual(StringConstants.images.rawValue, "Images")
        XCTAssertEqual(StringConstants.loading.rawValue, "Please Wait...")
        XCTAssertEqual(StringConstants.openSettings.rawValue, "1. Open Settings")
        XCTAssertEqual(StringConstants.readAndWrite.rawValue, "3. Select Read and Write")
        XCTAssertEqual(StringConstants.tap.rawValue,  "2. Tap")
        XCTAssertEqual(StringConstants.greaterThanPhotos.rawValue, " > Photos")
        
        XCTAssertEqual(FloatConstants.generalAlertHeightRatio.rawValue, 0.25)
        XCTAssertEqual(FloatConstants.addActivityIndicatorWidthRatio.rawValue, 0.35)
        XCTAssertEqual(FloatConstants.addActivityIndicatorHeightRatio.rawValue, 0.26)
        XCTAssertEqual(FloatConstants.addActivityIndicatorYOffset.rawValue, 100)
    }

}

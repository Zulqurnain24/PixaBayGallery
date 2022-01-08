//
//  FancyLoaderViewTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import UIKit
import XCTest
@testable import PixaBayGallery

class FancyLoaderViewTests: XCTestCase {
    
    var sut: FancyLoaderView!
    
    override func setUp() {
        super.setUp()
        sut = FancyLoaderView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFancyLoaderView() {
       XCTAssertNotNil(sut)
       XCTAssertNotNil(sut.activityIndicator)
       XCTAssertNotNil(sut.label)
       XCTAssertNotNil(sut.titleLabelText)
       sut.activityIndicator.startAnimating()
        XCTAssertEqual(sut.activityIndicator.isAnimating, true)
        sut.label.text = "Gloves"
        XCTAssertEqual(sut.label.text, "Gloves")
        sut.titleLabelText = "AED 42"
        XCTAssertEqual(sut.label.text, "AED 42")
    }

}

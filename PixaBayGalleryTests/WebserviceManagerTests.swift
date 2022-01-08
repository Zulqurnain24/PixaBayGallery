//
//  WebserviceManagerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//
import XCTest
@testable import PixaBayGallery

class WebserviceManagerTests: XCTestCase {

    var sut: WebserviceManager!
    
    override func setUpWithError() throws {
        sut = WebserviceManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testShouldMock() {
        sut.shouldMock = true
        XCTAssertTrue(sut.shouldMock ?? false)
    }
    
    func testSearch() {
        let expectation = self.expectation(description: #function)
        sut.shouldMock = true
        sut.search("flower", completionHandler: { [weak self] result  in
            switch result {
            case .success(let pixaBayImages):
                XCTAssertTrue(pixaBayImages.count == 20)
                expectation.fulfill()
            case .failure(_):
              break
            }
        })
        self.waitForExpectations(timeout: 5)
    }
}

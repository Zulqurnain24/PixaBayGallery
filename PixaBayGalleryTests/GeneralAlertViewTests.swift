//
//  GeneralAlertViewTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import XCTest
@testable import PixaBayGallery

class GeneralAlertViewTests: XCTestCase {
    
    var sut: GeneralAlertView!
    
    override func setUp() {
        super.setUp()
        sut = GeneralAlertView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGeneralAlertView() {
       XCTAssertNotNil(sut)
       XCTAssertNotNil(sut.promptDescriptionLabel)
       XCTAssertNotNil(sut.promptTitleLabel)
       XCTAssertNotNil(sut.submitButton)
        sut.submitButtonCallback = {
            
        }
       XCTAssertNotNil(sut.submitButtonCallback)
        sut.promptDescriptionLabel.text = "Please restore internet connection"
        XCTAssertEqual(sut.promptDescriptionLabel.text, "Please restore internet connection")
      sut.promptTitleLabel.text = "Error"
      XCTAssertEqual(sut.promptTitleLabel.text, "Error")
    }

}

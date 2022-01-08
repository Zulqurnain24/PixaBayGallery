//
//  BaseViewControllerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import UIKit
import XCTest
@testable import PixaBayGallery

class BaseViewControllerTests: XCTestCase {
    
    var sut: BaseViewController!
    
    override func setUp() {
        super.setUp()
        sut = BaseViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBaseViewController() {
       XCTAssertNotNil(sut)
       XCTAssertNotNil(sut.view)
    }

}

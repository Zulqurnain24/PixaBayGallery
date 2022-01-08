//
//  HUBManagerTests.swift
//  PixaBayGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import XCTest
@testable import PixaBayGallery

class HUBManagerTests: XCTestCase {

    var viewController = UIViewController()

    func testAddActivityIndicator() throws {
        HUDManager.addActivityIndicator("Testing", viewController)
        XCTAssertEqual(viewController.view.subviews.filter({$0 is FancyLoaderView}).count, 1)
        XCTAssertEqual((viewController.view.subviews.filter({$0 is FancyLoaderView}).first as? FancyLoaderView)?.titleLabelText, "Testing")
    }

    func testRemoveHUD() throws {
        HUDManager.addActivityIndicator("Testing", viewController)
        HUDManager.removeHUD(viewController)
        XCTAssertEqual(viewController.view.subviews.filter({$0 is FancyLoaderView}).count, 0)
    }
    
    func testShowGeneralAlert() throws {
        HUDManager.showGeneralAlert(viewController: viewController, title: "Testing", message: "message")
        XCTAssertEqual(viewController.view.subviews.filter({$0 is GeneralAlertView}).count, 1)
        XCTAssertEqual((viewController.view.subviews.filter({$0 is GeneralAlertView}).first as? GeneralAlertView)?.promptTitleLabel.text, "Testing")
        XCTAssertEqual((viewController.view.subviews.filter({$0 is GeneralAlertView}).first as? GeneralAlertView)?.promptDescriptionLabel.text, "message")
    }
}

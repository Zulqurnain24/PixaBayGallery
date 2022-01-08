//
//  BaseViewController.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
    }
}

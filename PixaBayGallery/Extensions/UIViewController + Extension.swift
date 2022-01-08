//
//  UIViewController + Extension.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import UIKit

extension UIViewController {
    func mimicVCLifeCycle() {
        loadView()
        viewDidLoad()
        viewWillAppear(true)
        viewDidAppear(true)
    }
}

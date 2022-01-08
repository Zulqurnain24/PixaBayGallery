//
//  PhotoGalleryViewController + Extension.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 18/12/2021.
//

import UIKit

extension PhotoCollectionViewController {
    func stub() -> PhotoCollectionViewController? {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let photoCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "\(PhotoCollectionViewController.self)") as? PhotoCollectionViewController
        photoCollectionViewController?.photoCollectionViewModel.webserviceManager.shouldMock = true
        photoCollectionViewController?.mimicVCLifeCycle()
        
        return photoCollectionViewController
    }
}

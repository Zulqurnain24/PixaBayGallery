//
//  LargePhotoViewController.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//


import UIKit
import Photos
import Kingfisher

class LargePhotoViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    var largePhotoViewModel = LargePhotoViewModel()
    var authStatus = PHPhotoLibrary.authorizationStatus()
    var imageSavedToGallery = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make sure we can access the photo
        guard let url = largePhotoViewModel.largeImageURL else {
            // otherwise load the image from the url
            self.imageView?.image = #imageLiteral(resourceName: "defaultImage")
            return
        }
        
        HUDManager.addActivityIndicator("Loading image...", self)
        self.imageView?.kf.setImage(with: url).map({ task in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                HUDManager.removeHUD(self)
            }
        })
        
    }
    
    // MARK: - Saving Photos
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        switch(authStatus) {
        case .authorized:
            // if authorized save the photo
            savePhoto(imageView?.image ?? #imageLiteral(resourceName: "defaultImage"))
            imageSavedToGallery = true
        case .notDetermined:
            // if user has not been asked, ask them
            PHPhotoLibrary.requestAuthorization() { granted in
                switch(granted) {
                case .authorized:
                    // the user authorized us, save the photo
                    DispatchQueue.main.async {
                        self.savePhoto(self.imageView?.image ?? #imageLiteral(resourceName: "defaultImage"))
                    }
                default:
                    // the user didn't authorize us, show alert
                    self.showAuthAlert()
                }
            }
        default:
            // the user didn't authorize us, show alert
            showAuthAlert()
        }
    }
    
    /// Save image to photo library
    /// - Assumes authorization to access photo library
    private func savePhoto(_ image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            if success {
                // image successfully saved, let the user know
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Success",
                                                            message: "Photo saved!",
                                                            preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        alertController.dismiss(animated: true)
                    }
                }
            }
            else if let error = error {
                print("🔴 LOG : Class: \(self) Function: \(#function), Error: Error saving photo - \(error.localizedDescription)")
            } else {
                print("🔴 LOG : Class: \(self) Function: \(#function), Error: Error saving photo")
            }
        })
    }
    
    /// Show warning when user has denied giving permissions
    private func showAuthAlert() {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") else {
            print("Error: Unable to get bundle name")
            return
        }

        let message = """
        \(StringConstants.permissionForPhotos.rawValue)
        
        \(StringConstants.openSettings.rawValue)
        \(StringConstants.tap.rawValue)"\(bundleName)"\(StringConstants.greaterThanPhotos.rawValue)
        \(StringConstants.readAndWrite.rawValue)"
        """
        let alertController = UIAlertController(title: "\(StringConstants.permissionNeeded.rawValue)",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "\(StringConstants.dismiss.rawValue)", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  PhotoCollectionViewController.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit
import Kingfisher

class PhotoCollectionViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchDescriptionImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchBar = UISearchBar()

    private let segueIdentifier = "goLargePhotoViewController"
    private let reuseIdentifier = "PhotoCell"
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let paddingSize: CGFloat = 1.0
    var photoCollectionViewModel = PhotoCollectionViewModel(imageList: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up search bar
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        self.photoCollectionViewModel.refreshCompletionHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination should always be a LargePhotoViewController
        guard let photoViewController = segue.destination as? LargePhotoViewController else {
            fatalError()
        }
        
        // set up the destination VC
        if segue.identifier == segueIdentifier {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                photoViewController.largePhotoViewModel.largeImageURL = URL(string: photoCollectionViewModel.imageList[indexPath.row].largeImageURLString)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollectionViewModel.imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell
        
        // configure the cell
        
        // set the imageView to match the current thumbnail
        let photo = photoCollectionViewModel.imageList[indexPath.item]
        cell?.imageId = photo._id
        cell?.imageView?.kf.setImage(with: photo.thumbnailURL)
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UISearchBarDelegate

extension PhotoCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // make sure search isn't empty
        guard let searchText = searchBar.text else { return }
        
        // clear the collection view
        self.photoCollectionViewModel.imageList.removeAll()
        self.collectionView?.reloadData()
        
        // show activity indicator while waiting for results
        HUDManager.addActivityIndicator("Please wait", self)
        
        //perform search from pixa search based on passed string
        photoCollectionViewModel.fetchSearchResultsList(searchString: searchText, { [weak self] in
            guard let weakSelf = self else { return }
            HUDManager.removeHUD(weakSelf)
        }, { [weak self] in
                guard let weakSelf = self else { return }
            HUDManager.removeHUD(weakSelf)
            HUDManager.showGeneralAlert(viewController: weakSelf, title: StringConstants.error.rawValue, message: StringConstants.networkErrorDescription.rawValue)
        })

        // hide the image describing the search
        searchDescriptionImage.isHidden = true
        // hide the keyboard
        searchBar.resignFirstResponder()
    }
}

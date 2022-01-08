//
//  PhotoCell.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var imageId: Int = 0
    @IBOutlet weak var imageView: UIImageView?

    func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("\(PhotoCell.self)", owner: self, options: nil)
    }
}

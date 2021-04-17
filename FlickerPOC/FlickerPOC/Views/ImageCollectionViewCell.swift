//
//  ImageCollectionViewCell.swift
//  FlickerPOC
//
//  Created by Kavish Joshi on 6/22/20.
//  Copyright © 2020 Kavish Joshi. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let nibName = "ImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil

    }
    
    var model: ImageModel? {
        didSet {
            if let model = model {
                self.imageView.image = UIImage(named: "placeholder")
                self.imageView.downloadImage(model.imageURL)
            }
        }
    }

}

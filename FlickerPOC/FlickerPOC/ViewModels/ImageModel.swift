//
//  ImageModel.swift
//  FlickerPOC
//
//  Created by Kavish Joshi on 6/22/20.
//  Copyright © 2020 Kavish Joshi. All rights reserved.
//
import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        imageURL = photo.imageURL
    }
}

//
//  FlickrRequestConfig.swift
//  FlickerPOC
//
//  Created by Kavish Joshi on 6/22/20.
//  Copyright © 2020 Kavish Joshi. All rights reserved.
//

import UIKit

enum FlickrRequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: FlickrConstants.searchURL, searchText, pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}

//
//  FlickrViewModel.swift
//  FlickerPOC
//
//  Created by Kavish Joshi on 6/22/20.
//  Copyright © 2020 Kavish Joshi. All rights reserved.
//
import UIKit


class FlickrViewModel: NSObject {

    private(set) var photoArray = [FlickrPhoto]()
    private var searchText = ""
    private var pageNo = 1
    private var totalPageNo = 1
    
    var showAlert: ((String) -> Void)?
    var dataUpdated: (() -> Void)?
    
    func search(text: String, completion:@escaping () -> Void) {
        searchText = text
        photoArray.removeAll()
        fetchResults(completion: completion)
        
    }
    
    //MARK: fetchResults
    ///To get the seach image results from flicker
    private func fetchResults(completion:@escaping () -> Void) {
        
        FlickrSearchService().request(searchText, pageNo: pageNo) { (result) in
        
            GCD.runOnMainThread {
                            
                switch result {
                case .Success(let results):
                    if let result = results {
                        self.totalPageNo = result.pages
                        self.photoArray.append(contentsOf: result.photo)
                        self.dataUpdated?()
                    }
                    completion()
                case .Failure(let message):
                    self.showAlert?(message)
                    completion()
                case .Error(let error):
                    if self.pageNo > 1 {
                        self.showAlert?(error)
                    }
                    completion()
                }
            }
        }
    }
    
    //MARK: fetchNextPage
    ///maintaning the page count 
    func fetchNextPage(completion:@escaping () -> Void) {
        if pageNo < totalPageNo {
            pageNo += 1
            fetchResults {
                completion()
            }
        } else {
            completion()
        }
    }
    
}

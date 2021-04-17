//
//  ImageDownloadOperation.swift
//  FlickerPOC
//
//  Created by Kavish Joshi on 6/22/20.
//  Copyright © 2020 Kavish Joshi. All rights reserved.
//


import UIKit

typealias ImageCompletion = (_ image : UIImage?, _ url : String) -> Void

class ImageDownloadOperation: Operation {
    
    let url: String?
    var customCompletionBlock: ImageCompletion?
    
    init(url: String, completionBlock: @escaping ImageCompletion) {
        self.url = url
        self.customCompletionBlock = completionBlock
    }
    
    override func main() {
        
        if self.isCancelled { return }
        
        if let url = self.url {
        
            if self.isCancelled { return }
            
            NetworkManager.shared.downloadImage(url) { (result) in
            
                GCD.runOnMainThread {
                    switch result {
                    case .Success(let image):
                        if self.isCancelled { return }
                        if let completion = self.customCompletionBlock{
                            completion(image, url)
                        }
                    default:
                        if self.isCancelled { return }
                        break
                    }
                }
            }
        }
    }
}


class GCD {
    
    static func runAsynch(closure: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            closure()
        }
    }
    
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}

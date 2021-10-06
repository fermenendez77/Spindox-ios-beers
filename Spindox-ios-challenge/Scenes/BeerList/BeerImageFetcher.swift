//
//  BeerImageFetcher.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 06/10/2021.
//

import Foundation
import UIKit

protocol BeerImageFetcher {
    
    func image(from url : String,
               completionHandler : @escaping (Result<UIImage,ErrorData>) -> Void)
}

class BeerImageFetcherImp : BeerImageFetcher {
    
    let service = ImageDownloaderService()
    
    func image(from url: String,
               completionHandler: @escaping (Result<UIImage, ErrorData>) -> Void) {
        service.image(from: url) { completionHandler($0) }
    }

}

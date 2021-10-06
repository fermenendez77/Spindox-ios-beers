//
//  ImageDownloaderService.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 06/10/2021.
//

import Foundation
import UIKit

class ImageDownloaderService {
    
    func image(from url : String,
               completionHandler : @escaping (Result<UIImage,ErrorData>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.badRequestError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else {
                      DispatchQueue.main.async {
                          completionHandler(.failure(.networkingError))
                      }
                      return
            }
            DispatchQueue.main.async {
                completionHandler(.success(image))
            }
        }
        task.resume()
    }
}



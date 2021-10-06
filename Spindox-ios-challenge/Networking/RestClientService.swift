//
//  RestClientService.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import Foundation

class RestClientService {
    
    var urlBase: String
    var urlSession: URLSession = URLSession(configuration: .default)
    
    
    init(urlBase : String) {
        self.urlBase = urlBase
    }

    func dataRequest<T>(endpoint: String,
                        queryItems: [URLQueryItem]? = nil,
                        returnType: T.Type,
                        completionHandler: @escaping (Result<T,ErrorData>) -> Void) where T : Decodable {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.urlBase
        urlComponents.path = endpoint
        if let query = queryItems {
            urlComponents.queryItems = query
        }
        let url = urlComponents.url!
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.networkingError))
                    }
                    return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.badFormatError))
                }
            }
            
        }
        dataTask.resume()
    }
    
}

enum ErrorData : Error {
    
    case networkingError
    case badRequestError
    case badFormatError
}

//
//  BeerListDataFetcher.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import Foundation

protocol BeerListDataFetcher {
    
    func fetchData(page : Int,
                   completionHandler : @escaping (Result<BeerResponse,ErrorData>) -> Void)
}

class BeerListDataFetcherImp : BeerListDataFetcher {
    
    let restClientService = RestClientService(urlBase: "api.punkapi.com")
    
    func fetchData(page: Int,
                   completionHandler: @escaping (Result<BeerResponse, ErrorData>) -> Void) {
        
        restClientService.dataRequest(endpoint: "/v2/beers",
                                      returnType: BeerResponse.self) { result in
            completionHandler(result)
        }
    }
}

//
//  BeerListViewModelTests.swift
//  Spindox-ios-challengeTests
//
//  Created by Fernando Menendez on 05/10/2021.
//

import XCTest
@testable import Spindox_ios_challenge

class BeerListViewModelTests: XCTestCase {

    func testIsError() throws {
        let mockDataFetcher = MockBeerListDataFetcher()
        mockDataFetcher.isError = true
        let viewModel = BeerListViewModel(dataFetcher: mockDataFetcher)
        viewModel.fetchData()
        XCTAssertTrue(viewModel.isError.value,
                      "isError should be true when the fetchData fails")
    }
    
    func testSuccess() throws {
        let mockDataFetcher = MockBeerListDataFetcher()
        mockDataFetcher.isError = false
        let viewModel = BeerListViewModel(dataFetcher: mockDataFetcher)
        viewModel.fetchData()
        XCTAssertFalse(viewModel.isError.value,
                       "isError should be false when the data is succesfully loaded")
        XCTAssert(viewModel.beersCount > 0,
                  "beersCount should be greater than 0 when the data is succesfully loaded")
        XCTAssertFalse(viewModel.isLoading.value,
                       "isLoading should be false when the data is loaded")
    }
    
    func testFilter() throws {
        let mockDataFetcher = MockBeerListDataFetcher()
        mockDataFetcher.isError = false
        let viewModel = BeerListViewModel(dataFetcher: mockDataFetcher)
        viewModel.fetchData()
        viewModel.filter(with: "Buzz")
        XCTAssert(viewModel.filteredBeers.value.count == 1)
        
    }
}

class MockBeerListDataFetcher : BeerListDataFetcher {
    
    var isError = false
    var isLoading = false
    
    func fetchData(page: Int, completionHandler: @escaping (Result<BeerResponse, ErrorData>) -> Void) {
        if isError {
            completionHandler(.failure(.networkingError))
        } else {
            let response = try! JSONDecoder().decode(BeerResponse.self,
                                                from: beerListResponse)
            completionHandler(.success(response))
        }
    }
    
    
}

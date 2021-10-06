//
//  BeerListViewModel.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import Foundation

class BeerListViewModel {
    
    // Dependencies
    let dataFetcher : BeerListDataFetcher
    
    // Data Binding
    public var beers : [Beer] = []
    public var filteredBeers: Binding<[Beer]> = Binding([])
    public var isLoading : Binding<Bool> = Binding(false)
    public var isError : Binding<Bool> = Binding(false)
    public var beersCount : Int { filteredBeers.value.count }
    
    public init(dataFetcher : BeerListDataFetcher = BeerListDataFetcherImp()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchData() {
        isError.value = false
        isLoading.value = true
        dataFetcher.fetchData(page: 1) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isLoading.value = false
            
            switch result {
            case .success(let beers):
                self.beers = beers
                self.filteredBeers.value = beers
            case .failure(_):
                self.isError.value = true
                self.beers = []
                self.filteredBeers.value = []
            }
        }
    }
    
    
    func beer(for indexPath : IndexPath) -> Beer {
        return filteredBeers.value[indexPath.row]
    }
    
    func filter(with value : String) {
        filteredBeers.value = beers.filter { $0.name.contains(value) }
    }
}

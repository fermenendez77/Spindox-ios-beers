//
//  BeerListViewModel.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import Foundation
import UIKit

class BeerListViewModel {
    
    // Dependencies
    let dataFetcher : BeerListDataFetcher
    let imageFetcher : BeerImageFetcher
    
    // Data Binding
    public var beers : [Beer] = []
    public var filteredBeers: Binding<[Beer]> = Binding([])
    public var isLoading : Binding<Bool> = Binding(false)
    public var isError : Binding<Bool> = Binding(false)
    public var beersCount : Int { filteredBeers.value.count }
    
    internal var cellsViewModels : [Int: BeerCellViewModel ] = [:]
    
    public init(dataFetcher : BeerListDataFetcher = BeerListDataFetcherImp(),
                imageFetcher : BeerImageFetcher = BeerImageFetcherImp()) {
        self.dataFetcher = dataFetcher
        self.imageFetcher = imageFetcher
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
    
    public func didSelectRow(at indexPath : IndexPath) -> UIViewController {
        let beer = beers[indexPath.row]
        let viewModel = BeerDetailViewModel(with: beer)
        viewModel.image = cellsViewModels[beer.id]?.image.value
        let detailVC = BeerDetailViewController(viewModel: viewModel)
        return detailVC
    }
    
    public func cellViewModel(for indexPath : IndexPath) -> BeerCellViewModel {
        let beer = filteredBeers.value[indexPath.row]
        if let viewModel = cellsViewModels[beer.id] {
            return viewModel
        } else {
            let viewModel = BeerCellViewModel(with: beer)
            cellsViewModels[beer.id] = viewModel
            return viewModel
        }
    }

    
    public func filter(with value : String) {
        if value.count == 0 {
            filteredBeers.value = beers
        } else {
            let text = value.lowercased()
            filteredBeers.value = beers.filter { $0.name.lowercased().contains(text)
            }
        }
    }
}

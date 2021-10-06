//
//  BeerDetailViewModel.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 06/10/2021.
//

import Foundation
import UIKit

class BeerDetailViewModel {
    
    let imageFetcher : BeerImageFetcher
    let beer : Beer
    
    init(with beer : Beer,
         imageFetcher : BeerImageFetcher = BeerImageFetcherImp()) {
        self.beer = beer
        self.imageFetcher = imageFetcher
        fetchImage()
    }
    
    var name : String { beer.name }
    var firstBrewed : String { "First Brewed : \(beer.firstBrewed) "}
    var description : String { beer.beerDescription }
    var foodPairing : String {
        let formattedString = beer.foodPairing.reduce("") { "\($0) 🔸 \($1) \n"}
        return formattedString
    }
    
    var tips : String { beer.brewersTips }
    var image : Binding<UIImage?> = Binding(nil)
    
    private func fetchImage() {
        imageFetcher.image(from : beer.imageURL) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let image):
                self.image.value = image
            case .failure(_):
                break
            }
        }
    }
}

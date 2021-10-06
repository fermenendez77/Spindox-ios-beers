//
//  BeerCellViewModel.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 06/10/2021.
//

import Foundation
import UIKit

class BeerCellViewModel {
    
    // Model
    let beer : Beer
    
    //Dependencies
    var imageFetcher : BeerImageFetcher
    
    // Properties
    var image : Binding<UIImage?> = Binding(nil)
    var name : String { beer.name }
    var description : String { beer.beerDescription }
    var tagLine : String { beer.tagline }
    var alcohol : String { "Alcohol : \(beer.abv)"}
    var ibu : String {
        var text : String
        if let ibu = beer.ibu {
            text = "IBU : \(ibu)"
        } else {
            text = "IBU : N/A"
        }
        return text
    }
    
    init(with beer : Beer,
         imageFetcher : BeerImageFetcher = BeerImageFetcherImp()) {
        self.beer = beer
        self.imageFetcher = imageFetcher
    }
    
    func fetchImage() {
        if let image = image.value {
            self.image.value = image
        } else {
            imageFetcher.image(from: beer.imageURL) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                    case .success(let image):
                        self.image.value = image
                    case .failure(_):
                        self.image.value = UIImage(named: "placeholder")
                }
            }
        }
    }
}

//
//  BeerDetailViewController.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 06/10/2021.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    let viewModel : BeerDetailViewModel
    
    public init(viewModel : BeerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstBrewedLabel: UILabel!
    @IBOutlet weak var foodParingLabel: UILabel!
    @IBOutlet weak var brewerTipsLabel: UILabel!
    @IBOutlet weak var brewerTipsContentLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var foodPairingContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureImage()
    }
    
    private func configureLabels() {
        nameLabel.text = viewModel.name
        firstBrewedLabel.text = viewModel.firstBrewed
        descLabel.text = viewModel.description
        brewerTipsContentLabel.text = viewModel.tips
        foodPairingContentLabel.text = viewModel.foodPairing
        self.title = viewModel.name
    }
    
    func configureImage() {
        viewModel.image.bind { [weak self] image in
            guard let self = self,
                  let image = image else {
                      return
            }
            self.beerImageView.image = image
        }
    }
}

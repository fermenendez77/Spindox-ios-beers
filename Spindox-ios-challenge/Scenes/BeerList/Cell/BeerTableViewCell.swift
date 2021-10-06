//
//  BeerTableViewCell.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    var viewModel : BeerCellViewModel? {
        didSet {
            configureImageBinding()
            viewModel?.fetchImage()
            configureLabels()
        }
    }
    
    @IBOutlet weak var imageBeerView: UIImageView!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    
    public static var identifier = "BeerTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureLabels() {
        nameLabel.text = viewModel?.name
        descLabel.text = viewModel?.description
        tagLineLabel.text = viewModel?.tagLine
        alcoholLabel.text = viewModel?.alcohol
        ibuLabel.text = viewModel?.ibu
    }
    
    private func configureImageBinding() {
        viewModel?.image.bind { [weak self] image in
            guard let self = self else {
                return
            }
            self.imageBeerView.image = image
        }
    }
}

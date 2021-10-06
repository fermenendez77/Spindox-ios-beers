//
//  BeerTableViewCell.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
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

        // Configure the view for the selected state
    }
    
    var image : String = "" {
        didSet {
            let url = URL(string: image)!
            let task = URLSession.shared.dataTask(with: url) { [weak self] data,
                                                    response, error in
                guard let self = self,
                      let data = data,
                      let image = UIImage(data: data) else {
                          return
                }
                DispatchQueue.main.async {
                    self.imageBeerView.image = image
                }
            }
            task.resume()
        }
    }
    
}

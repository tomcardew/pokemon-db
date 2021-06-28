//
//  PokemonItemCell.swift
//  pokemon-db
//
//  Created by Admin on 28/06/21.
//

import UIKit
import MapleBacon

class PokemonItemCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = .black
        self.contentView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        
        self.contentView.bringSubviewToFront(self.pokemonImage)
        self.contentView.bringSubviewToFront(self.nameLabel)
    }
    
    public func configure(from: PokemonListItem) {
        nameLabel.text = from.name.capitalized
        self.pokemonImage.setImage(with: URL(string: from.getImage()))
        numberLabel.text = "#\(from.getId())"
    }

}

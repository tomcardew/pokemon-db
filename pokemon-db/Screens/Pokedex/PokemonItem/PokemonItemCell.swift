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
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = .white
        typeLabel.isHidden = true
        self.contentView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        
        self.contentView.bringSubviewToFront(self.pokemonImage)
        self.contentView.bringSubviewToFront(self.typeLabel)
        self.contentView.bringSubviewToFront(self.nameLabel)
    }
    
    public func configure(from: PokemonListItem) {
        nameLabel.text = from.name.capitalized
        self.pokemonImage.setImage(with: URL(string: from.getImage()))
        numberLabel.text = "#\(from.getId())"
        from.getData(completion: { (pokemon, error) in
            if let pokemon = pokemon {
                self.typeLabel.isHidden = false
                self.typeLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
                self.typeLabel.text = pokemon.types[0].type.name.rawValue.uppercased()
                self.typeLabel.clipsToBounds = true
                self.typeLabel.layer.cornerRadius = 8
                self.contentView.backgroundColor = pokemon.getMainTypeColor()
            }
        })
    }

}

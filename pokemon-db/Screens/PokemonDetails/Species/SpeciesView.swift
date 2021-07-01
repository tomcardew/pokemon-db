//
//  SpeciesView.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class SpeciesView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet weak var heightContainer: UIVisualEffectView!
    @IBOutlet weak var weightContainer: UIVisualEffectView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SpeciesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(pokemonData: PokemonData, pokemonSpecie: PokemonSpecie, bgColor: UIColor?) {
        self.mainView.layer.cornerRadius = 10
        self.mainView.backgroundColor = bgColor ?? UIColor.pokeGreen()
        self.heightContainer.layer.cornerRadius = 10
        self.weightContainer.layer.cornerRadius = 10
        self.heightContainer.clipsToBounds = true
        self.weightContainer.clipsToBounds = true
        
        self.weightLabel.text = "\(pokemonData.getWeightKilograms()) Kg"
        self.heightLabel.text = "\(pokemonData.getHeightMeters()) m"
        
        let flavorText = pokemonSpecie.flavorTextEntries[0].flavorText.replacingOccurrences(of: "\n", with: " ")
        
        self.flavorLabel.text = flavorText.replacingOccurrences(of: "\u{000C}", with: " ")
        if bgColor!.isLight()! {
            self.flavorLabel.textColor = .black
        } else {
            self.flavorLabel.textColor = .white
        }
    }

}

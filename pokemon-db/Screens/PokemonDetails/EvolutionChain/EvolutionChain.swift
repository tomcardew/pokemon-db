//
//  EvolutionChain.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import UIKit

class EvolutionChain: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    private var navigation: UINavigationController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EvolutionChain", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(data: PokemonEvolutionChain, navigation: UINavigationController) {
        self.navigation = navigation
        let chain = data.chain
        let items = self.generateEvolutionItems(chain: chain, items: [])
        for item in items {
            self.stackView.addArrangedSubview(item)
        }
    }
    
    private func generateEvolutionItems(chain: PokemonChain, items: [PokemonItem]) -> [PokemonItem] {
        var pokemonItems = items
        let view = PokemonItem()
        let url = chain.species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
        var level = ""
        if chain.evolutionDetails.count > 0, let minLevel = chain.evolutionDetails[0].minLevel {
            level = "Level \(minLevel)"
        } else if chain.evolutionDetails.count > 0, chain.evolutionDetails[0].minHappiness != nil {
            level = "Happiness"
        }
        view.configureView(url: url, level: level)
        
        let gesture = PokemonGestureRecognizer(target: self, action: #selector(openPokemonDetails))
        gesture.pokemonSelected = PokemonListItem(name: chain.species.name, url: url)
        view.addGestureRecognizer(gesture)
        
        pokemonItems.append(view)
        if chain.evolvesTo.count > 0 {
            return generateEvolutionItems(chain: chain.evolvesTo[0], items: pokemonItems)
        } else {
            return pokemonItems
        }
    }
    
    @objc func openPokemonDetails(gesture: PokemonGestureRecognizer) {
        let storyboard = AppStoryboard.PokemonDetails
        let vc = PokemonDetailsViewController.instantiate(fromAppStoryboard: storyboard)
        vc.data = gesture.pokemonSelected
        navigation?.pushViewController(vc, animated: true)
    }

}

class PokemonGestureRecognizer: UITapGestureRecognizer {
    
    var pokemonSelected: PokemonListItem?
    var pokemonData: PokemonData?
    var abilitySelected: PokemonAbility?
    
}

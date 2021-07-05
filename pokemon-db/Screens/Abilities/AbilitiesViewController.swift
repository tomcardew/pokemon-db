//
//  AbilitiesViewController.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import UIKit

class AbilitiesViewController: UIViewController {

    @IBOutlet weak var btnBackContainer: UIVisualEffectView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var abilitySubtitleLabel: UILabel!
    
    @IBOutlet weak var effectContainer: UIView!
    @IBOutlet weak var effectTitleLabel: UILabel!
    @IBOutlet weak var effectDescriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionSubtitleLabel: UILabel!
    
    @IBOutlet weak var pokemonsContainer: UIView!
    @IBOutlet weak var pokemonsTitleLabel: UILabel!
    @IBOutlet weak var pokemonStackView: UIStackView!
    
    public var pokemon: PokemonData?
    public var ability: PokemonAbility?
    public var navigation: UINavigationController?
    
    private var color: UIImageColors?
    private var isLight = false
    private let presenter = AbilitiesPresenter(service: PokemonService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUi()
        presenter.setViewDelegate(delegate: self)
        presenter.getAbilityInfo(url: ability!.ability.url)
    }
    
    private func setupUi() {
        self.btnBackContainer.layer.cornerRadius = 15
        self.btnBackContainer.clipsToBounds = true
        if self.isBeingPresentedInFormSheet() {
            self.btnBackContainer.isHidden = true
        }
        
        self.effectContainer.layer.cornerRadius = 10
        self.effectContainer.clipsToBounds = true
        self.descriptionContainer.layer.cornerRadius = 10
        self.descriptionContainer.clipsToBounds = true
        
        guard let pokemon = pokemon else { return }
        UIImageView().setImage(with: URL(string: pokemon.getImage()), completion: { image in
            image?.getColors(quality: .lowest, { colors in
                self.color = colors
                self.effectContainer.backgroundColor = colors?.background
                self.headerView.backgroundColor = colors?.background
                self.descriptionContainer.backgroundColor = colors?.background
//                self.pokemonsContainer.backgroundColor = colors?.background
                self.isLight = colors?.background.isLight() ?? false
                
                self.configureColors()
            })
        })
        
        self.abilityLabel.text = ability?.ability.name.capitalized
    }
    
    private func loadData(data: PokemonAbilityDetails) {
        // Effect
        let effect = data.getEffectEntryByLanguage(lang: .en)
        self.effectDescriptionLabel.text = effect?.shortEffect.removeInnecesaryCharacters()
        
        // Description
        let flavor = data.getEffectFlavorByLanguage(lang: .en)
        self.descriptionSubtitleLabel.text = flavor?.flavorText.removeInnecesaryCharacters()
        
        //Pokemons
        let pokemons = data.pokemon
        for pokemon in pokemons {
            let item = PokemonItemHorizontal()
            item.frame = CGRect(x: 0, y: 0, width: self.pokemonStackView.bounds.width, height: 100)
            item.configureView(pokemon: PokemonListItem(name: pokemon.pokemon.name, url: pokemon.pokemon.url))
            
            let gesture = PokemonGestureRecognizer(target: self, action: #selector(openPokemonDetails(gesture:)))
            gesture.pokemonSelected = PokemonListItem(name: pokemon.pokemon.name, url: pokemon.pokemon.url)
            item.addGestureRecognizer(gesture)
            
            self.pokemonStackView.addArrangedSubview(item)
        }
        
        self.hideLoadingView()
    }
    
    @objc func openPokemonDetails(gesture: PokemonGestureRecognizer) {
        let pokemon = gesture.pokemonSelected
        let storyboard = AppStoryboard.PokemonDetails
        let vc = PokemonDetailsViewController.instantiate(fromAppStoryboard: storyboard)
        vc.data = pokemon
        
        if let navigation = self.navigation {
            self.dismiss(animated: true, completion: {
                navigation.pushViewController(vc, animated: true)
            })
        }
    }
    
    private func configureColors() {
        let color: UIColor = self.isLight ? .black : .white
        self.effectDescriptionLabel.textColor = color
        self.effectTitleLabel.textColor = color
        self.abilityLabel.textColor = color
        self.abilitySubtitleLabel.textColor = color
        self.descriptionTitleLabel.textColor = color
        self.descriptionSubtitleLabel.textColor = color
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AbilitiesViewController: AbilitiesDelegate {
    func didStartLoading() {
        self.showLoadingView(message: "Loading ability", parent: self.view, completion: nil)
    }
    
    func didLoadedData(data: PokemonAbilityDetails) {
        self.loadData(data: data)
    }
    
    func didReceiveError(error: String) {
        debugPrint(error)
    }
    
    
}

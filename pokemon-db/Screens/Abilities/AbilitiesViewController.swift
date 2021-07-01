//
//  AbilitiesViewController.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import UIKit

class AbilitiesViewController: UIViewController {

    @IBOutlet weak var btnBackContainer: UIVisualEffectView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var abilitySubtitleLabel: UILabel!
    
    @IBOutlet weak var effectContainer: UIView!
    @IBOutlet weak var effectTitleLabel: UILabel!
    @IBOutlet weak var effectDescriptionLabel: UILabel!
    
    public var pokemon: PokemonData?
    public var ability: PokemonAbility?
    
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
        
        guard let pokemon = pokemon else { return }
        UIImageView().setImage(with: URL(string: pokemon.getImage()), completion: { image in
            image?.getColors(quality: .lowest, { colors in
                self.color = colors
                self.effectContainer.backgroundColor = colors?.background
                self.headerView.backgroundColor = colors?.background
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
//        self.effectDescriptionLabel.textColor = self.color?.detail
//        self.effectTitleLabel.textColor = self.color?.primary ?? .black
        
        self.hideLoadingView()
    }
    
    private func configureColors() {
        let color: UIColor = self.isLight ? .black : .white
        self.effectDescriptionLabel.textColor = color
        self.effectTitleLabel.textColor = color
        self.abilityLabel.textColor = color
        self.abilitySubtitleLabel.textColor = color
    }

}

extension AbilitiesViewController: AbilitiesDelegate {
    func didStartLoading() {
        self.showLoadingView(message: "Loading ability", completion: nil)
    }
    
    func didLoadedData(data: PokemonAbilityDetails) {
        self.loadData(data: data)
    }
    
    func didReceiveError(error: String) {
        debugPrint(error)
    }
    
    
}

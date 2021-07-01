//
//  AbilitiesView.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class AbilitiesView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var abilitiesStackView: UIStackView!
    
    private var viewController: UIViewController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AbilitiesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(data: PokemonData, color: UIColor?, vc: UIViewController? = nil) {
        self.mainView.layer.cornerRadius = 10
        self.mainView.clipsToBounds = true
        self.mainView.backgroundColor = color
        
        self.viewController = vc
        
        for abilitie in data.abilities {
            let abilityBtn = AbilitieItem()
            abilityBtn.layer.cornerRadius = 10
            abilityBtn.clipsToBounds = true
            abilityBtn.configureView(abilitie: abilitie)
            
            let gesture = PokemonGestureRecognizer(target: self, action: #selector(openAbilities))
            gesture.pokemonData = data
            gesture.abilitySelected = abilitie
            abilityBtn.addGestureRecognizer(gesture)
            
            self.abilitiesStackView.addArrangedSubview(abilityBtn)
        }
    }
    
    @objc func openAbilities(gesture: PokemonGestureRecognizer) {
        let storyboard = AppStoryboard.Abilities
        let vc = AbilitiesViewController.instantiate(fromAppStoryboard: storyboard)
        vc.modalPresentationStyle = .formSheet
        vc.pokemon = gesture.pokemonData
        vc.ability = gesture.abilitySelected
        self.viewController?.present(vc, animated: true, completion: nil)
    }

}

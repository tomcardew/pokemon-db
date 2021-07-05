//
//  PokemonDetailsViewController.swift
//  pokemon-db
//
//  Created by Admin on 28/06/21.
//

import UIKit
import SwiftSVG

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backBtnContainerView: UIVisualEffectView!
    @IBOutlet weak var mainColoredView: UIView!
    @IBOutlet weak var marginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var typeStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typeStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var abilitiesViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var speciesView: SpeciesView!
    @IBOutlet weak var abilitiesView: AbilitiesView!
    @IBOutlet weak var statsView: StatsView!
    @IBOutlet weak var evolutionView: EvolutionChain!
    @IBOutlet weak var animatedSpriteView: AnimatedSprite!
    
    var data: PokemonListItem?
    var pokemon: PokemonData?
    var isDark: Bool = false
    
    private let presenter = PokemonDetailsPresenter(service: PokemonService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setViewDelegate(delegate: self)
        self.presenter.loadAllData(pokemon: data!)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isDark {
            return .darkContent
        }
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        marginTopConstraint.constant = self.view.safeAreaInsets.top * -1
    }
    
    public func configureView(data: PokemonData, color: UIColor?, image: UIImage?) {
        self.pokemon = data
        backBtnContainerView.layer.cornerRadius = 15
        backBtnContainerView.clipsToBounds = true
        nameLabel.textColor = .white
        self.nameLabel.text = data.name.capitalized
        self.idLabel.text = "#" + data.getId()
        if let image = image {
            self.imageView.image = image
        }
        if let color = color {
            self.mainColoredView.backgroundColor = color
            let dark = color.isLight() ?? false
            self.isDark = dark
            if dark {
                let effect = UIBlurEffect(style: .light)
                self.backBtnContainerView.effect = effect
                self.nameLabel.textColor = .black
                self.backBtn.tintColor = .black
                self.idLabel.textColor = .black
                titleView.gradientBackground(from: .clear, to: UIColor(red: 1, green: 1, blue: 1, alpha: 0.25), direction: .topRightToBottomLeft)
            } else {
                let effect = UIBlurEffect(style: .dark)
                self.backBtnContainerView.effect = effect
                self.nameLabel.textColor = .white
                self.idLabel.textColor = .white
                self.backBtn.tintColor = .white
                titleView.gradientBackground(from: .clear, to: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), direction: .topRightToBottomLeft)
            }
            setNeedsStatusBarAppearanceUpdate()
        }
        configureTypes(types: data.types)
        configureAbilities(data: data, color: color)
        configureStats(data: data, color: color)
        configureAnimatedSprite(data: data, color: color)
    }
    
    private func configureTypes(types: [PokemonTypes]) {
        self.typeStackViewWidth.constant = CGFloat(types.count * 45) - 5
        for type in types {
            let name = type.type.name
            let typePill = TypePill()
            typePill.configureView(name: name.rawValue.uppercased(), typeImage: name.getTypeIcon(), typeColor: name.getMainTypeColor())
            typeStackView.addArrangedSubview(typePill)
        }
    }
    
    private func configureAbilities(data: PokemonData, color: UIColor?) {
        self.abilitiesView.configureView(data: data, color: color, vc: self)
    }
    
    private func configureStats(data: PokemonData, color: UIColor?) {
        self.statsView.configureView(stats: data.stats!, color: color)
    }
    
    private func configureAnimatedSprite(data: PokemonData, color: UIColor?) {
        self.animatedSpriteView.configureView(urlToResource: data.getAnimatedGif(), color: color)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PokemonDetailsViewController: PokemonDetailsDelegate {
    
    func didLoadedSpeciesData(data: PokemonData, specie: PokemonSpecie, color: UIColor?) {
        self.speciesView.configureView(pokemonData: data, pokemonSpecie: specie, bgColor: color)
    }
    
    func didLoadingStarted() {
        self.showLoadingView(message: "Getting information", parent: nil, completion: nil)
    }
    
    func didLoadedData(data: PokemonData, color: UIColor?, image: UIImage?) {
        self.configureView(data: data, color: color, image: image)
        self.hideLoadingView()
        self.showAlert(message: "The information has been gathered completely!")
    }
    
    func didReceiveError(error: String) {
        self.hideLoadingView()
        self.showAlert(message: error, isError: true)
    }
    
    func didLoadedEvolutionData(data: PokemonEvolutionChain) {
        self.evolutionView.configureView(data: data, navigation: self.navigationController!)
    }
    
    
}

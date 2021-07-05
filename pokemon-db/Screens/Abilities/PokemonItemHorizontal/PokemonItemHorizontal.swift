//
//  PokemonItemHorizontal.swift
//  pokemon-db
//
//  Created by Admin on 03/07/21.
//

import UIKit

class PokemonItemHorizontal: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loadingView: UIVisualEffectView!
    
    private let presenter = PokemonItemHorizontalPresenter(service: PokemonService.shared)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PokemonItemHorizontal", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        presenter.setViewDelegate(delegate: self)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    public func configureView(pokemon: PokemonListItem) {
        presenter.loadData(url: pokemon.url)
    }
    
    private func loadInfo(pokemon: PokemonData) {
        self.idLabel.text = "#" + pokemon.getId()
        self.nameLabel.text = pokemon.name.capitalized
        self.mainImageView.setImageFromUrl(url: pokemon.getImage())
        self.bgImageView.setImageFromUrl(url: pokemon.getImage())
    }
}

extension PokemonItemHorizontal: PokemonItemHorizontalDelegate {
    func didLoadData(data: PokemonData) {
        self.loadingView.isHidden = true
        self.loadInfo(pokemon: data)
    }
    
    func didGetError(error: String) {
        print(error)
    }
    
    func didStartedLoading() {
        loadingView.isHidden = false
    }
    
    
}

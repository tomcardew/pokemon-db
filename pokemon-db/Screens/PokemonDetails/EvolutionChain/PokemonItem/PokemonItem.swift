//
//  PokemonItem.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import UIKit

class PokemonItem: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var viewModel: PokemonItemViewModel!
    private let presenter = PokemonItemPresenter(service: PokemonService.shared)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PokemonItem", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(url: String, level: String = "") {
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true

        self.viewModel = PokemonItemViewModel(service: PokemonService.shared, from: url)
        viewModel.updateView = { [weak self] in
            let pokemon = self?.viewModel.pokemon
            self?.idLabel.text = "#" + pokemon!.getId()
            self?.nameLabel.text = pokemon?.name.capitalized
            self?.levelLabel.text = level
        }
        viewModel.updateColors = { [weak self] in
            self?.updateColors(color: self?.viewModel.colors.textColor ?? .black)
            self?.contentView.backgroundColor = self?.viewModel.colors.bgColor
        }
        viewModel.updateImageView = { [weak self] in
            self?.imageView.image = self?.viewModel.currentImage
        }
        viewModel.initFetch()
    }
    
    private func updateColors(color: UIColor) {
        self.levelLabel.textColor = color
        self.idLabel.textColor = color
        self.nameLabel.textColor = color
    }

}

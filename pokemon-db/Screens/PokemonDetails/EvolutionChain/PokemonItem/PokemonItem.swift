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
        
        presenter.setViewDelegate(delegate: self)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(url: String, level: String = "") {
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        
        self.levelLabel.text = level
        
        self.presenter.loadData(url: url)
    }
    
    private func updateColors(isLight: Bool?) {
        if let isLight = isLight, isLight {
            self.levelLabel.textColor = .black
            self.idLabel.textColor = .black
            self.nameLabel.textColor = .black
        } else {
            self.levelLabel.textColor = .white
            self.idLabel.textColor = .white
            self.nameLabel.textColor = .white
        }
    }

}

extension PokemonItem: PokemonItemDelegate {
    
    func didLoadedData(data: PokemonData) {
        self.nameLabel.text = data.name.capitalized
        self.idLabel.text = "#" + data.getId()
        
        self.imageView.setImage(with: URL(string: data.getImage()), placeholder: nil, displayOptions: [], imageTransformer: nil, completion: { image in
            image?.getColors(quality: .lowest, { colors in
                self.contentView.backgroundColor = colors?.background
                self.updateColors(isLight: colors?.background.isLight())
            })
        })
        
    }
    
    func didGetError(error: String) {
        print(error)
    }
    
    
}

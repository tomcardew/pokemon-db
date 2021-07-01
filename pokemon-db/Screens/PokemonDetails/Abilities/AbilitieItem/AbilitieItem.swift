//
//  AbilitieItem.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class AbilitieItem: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var isHiddenIndicator: UIVisualEffectView!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AbilitieItem", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    public func configureView(abilitie: PokemonAbility) {
        nameLabel.text = abilitie.ability.name.capitalized
        if abilitie.isHidden {
            self.isHiddenIndicator.isHidden = false
        } else {
            self.isHiddenIndicator.isHidden = true
        }
    }

}

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
    
    public func configureView(data: PokemonData, color: UIColor?) {
        self.mainView.layer.cornerRadius = 10
        self.mainView.clipsToBounds = true
        self.mainView.backgroundColor = color
        
        for abilitie in data.abilities {
            let abilityBtn = AbilitieItem()
            abilityBtn.layer.cornerRadius = 10
            abilityBtn.clipsToBounds = true
            abilityBtn.configureView(abilitie: abilitie)
            self.abilitiesStackView.addArrangedSubview(abilityBtn)
        }
    }

}

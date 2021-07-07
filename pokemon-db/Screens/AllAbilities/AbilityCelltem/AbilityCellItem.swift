//
//  AbilityCellItem.swift
//  pokemon-db
//
//  Created by Admin on 07/07/21.
//

import UIKit

class AbilityCellItem: UICollectionViewCell {
    
    static let identifier = "AbilityCellItem"
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUi()
    }
    
    private func configureUi() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        let bgColor: UIColor = .random()
        self.backgroundColor = bgColor
        if bgColor.isLight() ?? true {
            self.abilityLabel.textColor = .black
        } else {
            self.abilityLabel.textColor = .white
        }
        
    }
    
    func setTitle(_ title: String) {
        self.abilityLabel.text = title
    }

}

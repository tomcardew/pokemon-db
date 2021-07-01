//
//  StatItemView.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class StatItemView: UIView {

    @IBOutlet weak var statWithConstraint: NSLayoutConstraint!
    @IBOutlet weak var statBar: UIVisualEffectView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var mainView: UIVisualEffectView!
    
    var statValue: Int?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("StatItemView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(name: String, value: Int, maxValue: Int = 100, isDark: Bool = false) {
        self.statValue = value
        
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        statBar.layer.cornerRadius = 10
        statBar.clipsToBounds = true
        
        nameLabel.text = name.uppercased()
        valueLabel.text = "\(value)"
        
        let multiplier = (CGFloat(value) / CGFloat(maxValue)) * CGFloat(0.96)
        let newConstraint = statWithConstraint.constraintWithMultiplier(multiplier)
        self.contentView.removeConstraint(statWithConstraint)
        newConstraint.isActive = true
        self.contentView.addConstraint(newConstraint)
        self.layoutIfNeeded()
        statWithConstraint = newConstraint
        
        if isDark {
            self.nameLabel.textColor = .white
        } else {
            self.nameLabel.textColor = .black
        }
    }

}

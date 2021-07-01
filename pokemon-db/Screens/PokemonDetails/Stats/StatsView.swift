//
//  StatsView.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class StatsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var statsStackView: UIStackView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("StatsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(stats: [PokemonStat], color: UIColor?) {
        self.mainView.layer.cornerRadius = 10
        self.mainView.clipsToBounds = true
        
        let isLight = color!.isLight()!
        if isLight {
            self.totalLabel.textColor = .black
        } else {
            self.totalLabel.textColor = .white
        }
        
        var total = 0
        var max = 0
        for stat in stats {
            if stat.baseStat > max {
                max = stat.baseStat
            }
        }
        
        for stat in stats {
            let statView = StatItemView()
            statView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: 30)
            statView.configureView(name: stat.stat.name, value: stat.baseStat, maxValue: max, isDark: !isLight)
            total += stat.baseStat
            self.statsStackView.addArrangedSubview(statView)
        }
        self.totalLabel.text = "Total: \(total)"
        self.mainView.backgroundColor = color
    }

}

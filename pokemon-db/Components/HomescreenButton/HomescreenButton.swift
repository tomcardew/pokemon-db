//
//  HomescreenButton.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import UIKit

class HomescreenButton: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HomescreenButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 10
    }
    
    public func initializeButton(label: String, color: UIColor) {
        buttonLabel.text = label
        contentView.backgroundColor = color
    }

}

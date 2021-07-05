//
//  ErrorBanner.swift
//  pokemon-db
//
//  Created by Admin on 04/07/21.
//

import UIKit

class AlertBanner: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AlertBanner", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        // generate shadow
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func configureView(message: String, isError: Bool = false) {
        self.messageLabel.text = message
        self.contentView.backgroundColor = isError ? .pokeRed() : .pokeGreen()
        self.imageView.image = isError ? UIImage(named: "ErrorWhite") : UIImage(systemName: "checkmark.circle")
    }

}

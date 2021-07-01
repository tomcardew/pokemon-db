//
//  TypePill.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class TypePill: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TypePill", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configureView(name: String, typeImage: UIImage?, typeColor: UIColor) {
        self.contentView.layer.cornerRadius = 20
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = typeColor
//        self.nameLabel.text = name
        self.imageView.image = typeImage
    }
}

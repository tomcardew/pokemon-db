//
//  AnimatedSprite.swift
//  pokemon-db
//
//  Created by Admin on 03/07/21.
//

import UIKit

class AnimatedSprite: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainView: UIView!
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
        Bundle.main.loadNibNamed("AnimatedSprite", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }
    
    public func configureView(urlToResource: String, color: UIColor?) {
        self.imageView.image = UIImage.gifImageWithURL(urlToResource)
        self.mainView.backgroundColor = color
    }

}

//
//  self.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
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
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func configure(message: String = "", parentView: UIView? = nil) {
        self.loadingLabel.text = message
        self.imageView.rotate(duration: CFTimeInterval(5))
    }

}

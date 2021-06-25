//
//  ErrorView.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import UIKit

protocol ErrorViewDelegate: NSObjectProtocol {
    func onRetryPress()
}

class ErrorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    weak var delegate: ErrorViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func initializeView(message: String, isDark: Bool = false) {
        errorMessageLabel.text = message
        if isDark {
            errorImageView.image = UIImage(named: "ErrorWhite")
        }
    }
    
    @IBAction func onRetryPress(_ sender: Any) {
        self.delegate?.onRetryPress()
    }
    
}

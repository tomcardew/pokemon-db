//
//  FloatingSearchBar.swift
//  pokemon-db
//
//  Created by Admin on 05/07/21.
//

import UIKit

protocol FloatingSearchBarDelegate: NSObjectProtocol {
    func didChangeValue(value: String)
    func willClose()
}

class FloatingSearchBar: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak private var delegate: FloatingSearchBarDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func setViewDelegate(delegate: FloatingSearchBarDelegate) {
        self.delegate = delegate
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FloatingSearchBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    public func configureView(placeholder: String = "", showCancelButton: Bool = true) {
        self.searchBar.delegate = self
        self.searchBar.placeholder = placeholder
        self.searchBar.showsCancelButton = showCancelButton
    }
    
    public func showView(parent: UIView, finalFrame: CGRect) {
        self.contentView.frame = CGRect(x: 0, y: -100, width: parent.bounds.width, height: 100)
        self.contentView.alpha = 0
        parent.addSubview(contentView)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 1
            self.contentView.frame = finalFrame
        })
    }
    
    public func hideView(parent: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: -100, width: parent.bounds.width, height: 100)
        }, completion: { result in
            self.removeFromSuperview()
        })
    }

}

extension FloatingSearchBar: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.didChangeValue(value: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.delegate?.willClose()
    }
}

//
//  PokemonDetailsViewController.swift
//  pokemon-db
//
//  Created by Admin on 28/06/21.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backBtnContainerView: UIVisualEffectView!
    @IBOutlet weak var mainColoredView: UIView!
    @IBOutlet weak var marginTopConstraint: NSLayoutConstraint!
    
    var data: PokemonData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtnContainerView.layer.cornerRadius = 15
        backBtnContainerView.clipsToBounds = true
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        marginTopConstraint.constant = self.view.safeAreaInsets.top * -1
    }
    
    public func configureView() {
        self.nameLabel.text = self.data!.name
        self.imageView.setImage(with: URL(string: self.data!.getImage()), completion: { image in
            let colors = image?.getColors()
            self.mainColoredView.backgroundColor = colors?.background
            self.nameLabel.textColor = colors?.primary
        })
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

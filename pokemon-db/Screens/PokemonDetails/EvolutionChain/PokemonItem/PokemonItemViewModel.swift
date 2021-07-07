//
//  PokemonItemViewModel.swift
//  pokemon-db
//
//  Created by Admin on 07/07/21.
//

import Foundation
import UIKit
import MapleBacon

struct BackgroundColors {
    var bgColor: UIColor = .lightGray
    var textColor: UIColor = .black
}

class PokemonItemViewModel {
    
    let url: String
    private let service: PokemonService
    
    var pokemon: PokemonData = PokemonData(id: 0, name: "", isDefault: false, height: 0.0, order: 0, weight: 0, sprites: PokemonSprites(backDefault: nil, frontDefault: nil), types: [PokemonTypes](), species: PokemonSpecies(name: "", url: ""), abilities: [PokemonAbility](), stats: nil) {
        didSet {
            self.updateView?()
        }
    }
    var currentImage: UIImage? = nil {
        didSet {
            self.updateImageView?()
            self.reloadColors()
        }
    }
    var colors: BackgroundColors = BackgroundColors() {
        didSet {
            self.updateColors?()
        }
    }
    var errorMessage: String = "" {
        didSet {
            self.displayErrorMessage?()
        }
    }
    
    init(service: PokemonService, from url: String) {
        self.service = service
        self.url = url
    }
    
    var updateView: (() ->  ())?
    var updateImageView: (() -> ())?
    var displayErrorMessage: (() -> ())?
    var updateColors: (() -> ())?

    func initFetch() {
        self.service.getPokemonDataC(url: self.url, completion: { result in
            switch result {
            case .success(let data):
                self.loadImage(from: data.getImage())
                self.pokemon = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        })
    }
    
    /**
     Loads an image from a URL
     - Parameter url: The URL to load the image from
     */
    private func loadImage(from url: String) {
        self.currentImage = UIImageView().getImageFromUrl(url: url)
    }
    
    private func reloadColors() {
        self.currentImage?.getColors({ colors in
            self.colors = BackgroundColors(bgColor: colors!.background, textColor: colors!.background.isLight()! ? .black : .white)
        })
    }
    
}

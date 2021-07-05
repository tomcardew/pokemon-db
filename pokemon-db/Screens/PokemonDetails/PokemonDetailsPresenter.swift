//
//  PokemonDetailsPresenter.swift
//  pokemon-db
//
//  Created by Admin on 30/06/21.
//

import Foundation
import UIKit

protocol PokemonDetailsDelegate: NSObjectProtocol {
    
    func didLoadingStarted()
    func didLoadedData(data: PokemonData, color: UIColor?, image: UIImage?)
    func didLoadedSpeciesData(data: PokemonData, specie: PokemonSpecie, color: UIColor?)
    func didLoadedEvolutionData(data: PokemonEvolutionChain)
    func didReceiveError(error: String)
    
}

class PokemonDetailsPresenter {
    
    private let service: PokemonService
    weak private var pokemonDetailsDelegate: PokemonDetailsDelegate?
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: PokemonDetailsDelegate) {
        self.pokemonDetailsDelegate = delegate
    }
    
    func loadAllData(pokemon: PokemonListItem) {
        self.pokemonDetailsDelegate?.didLoadingStarted()
        self.loadPokemonGeneralInfo(url: pokemon.url, completion: { (data, error) in
            guard let data = data else {
                self.pokemonDetailsDelegate?.didReceiveError(error: error ?? "Something went wrong")
                return
            }
            let imageView = UIImageView()
            imageView.setImageFromUrl(url: data.getImage(), { image in
                if let image = image {
                    image.getColors(quality: .lowest, { colors in
                        self.pokemonDetailsDelegate?.didLoadedData(data: data, color: colors?.background, image: image)
                        self.loadPokemonSpeciesInfo(url: data.species.url, completion: { (info, error) in
                            guard let specie = info else {
                                self.pokemonDetailsDelegate?.didReceiveError(error: error ?? "Something went wrong")
                                return
                            }
                            self.service.getPokemonEvolutions(url: specie.evolutionChain.url, onSuccess: { data in
                                self.pokemonDetailsDelegate?.didLoadedEvolutionData(data: data)
                            }, onError: { error in
                                self.pokemonDetailsDelegate?.didReceiveError(error: error)
                            })
                            self.pokemonDetailsDelegate?.didLoadedSpeciesData(data: data, specie: specie, color: colors?.background)
                        })
                    })
                }
            })
        })
    }
    
    func loadPokemonGeneralInfo(url: String, completion: @escaping(_ data: PokemonData?, _ error: String?) -> Void) {
        service.getPokemonData(url: url, onSuccess: { data in
            completion(data, nil)
        }, onError: { error in
            completion(nil, error)
        })
    }
    
    func loadPokemonSpeciesInfo(url: String, completion: @escaping(_ data: PokemonSpecie?, _ error: String?) -> Void) {
        service.getPokemonSpecies(url: url, onSuccess: { data in
            completion(data, nil)
        }, onError: { error in
            completion(nil, error)
        })
    }
    
}

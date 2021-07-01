//
//  PokemonItemPresenter.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import Foundation

protocol PokemonItemDelegate: NSObjectProtocol {
    func didLoadedData(data: PokemonData)
    func didGetError(error: String)
}

class PokemonItemPresenter {
    
    private let service: PokemonService
    weak private var delegate: PokemonItemDelegate?
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: PokemonItemDelegate) {
        self.delegate = delegate
    }
    
    func loadData(url: String) {
        self.service.getPokemonData(url: url, onSuccess: { data in
            self.delegate?.didLoadedData(data: data)
        }, onError: { error in
            self.delegate?.didGetError(error: error)
        })
    }
    
}

//
//  PokemonItemHorizontalPresenter.swift
//  pokemon-db
//
//  Created by Admin on 03/07/21.
//

import Foundation

protocol PokemonItemHorizontalDelegate: NSObjectProtocol {
    func didLoadData(data: PokemonData)
    func didGetError(error: String)
    func didStartedLoading()
}

class PokemonItemHorizontalPresenter {
    
    private let service: PokemonService
    weak private var delegate: PokemonItemHorizontalDelegate?
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: PokemonItemHorizontalDelegate) {
        self.delegate = delegate
    }
    
    func loadData(url: String) {
        self.delegate?.didStartedLoading()
        self.service.getPokemonData(url: url, onSuccess: { data in
            self.delegate?.didLoadData(data: data)
        }, onError: { error in
            self.delegate?.didGetError(error: error)
        })
    }
    
}

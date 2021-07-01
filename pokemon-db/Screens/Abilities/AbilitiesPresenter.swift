//
//  AbilitiesPresenter.swift
//  pokemon-db
//
//  Created by Admin on 01/07/21.
//

import Foundation

protocol AbilitiesDelegate: NSObjectProtocol {
    func didStartLoading()
    func didLoadedData(data: PokemonAbilityDetails)
    func didReceiveError(error: String)
}

class AbilitiesPresenter {
    
    private let service: PokemonService
    weak private var delegate: AbilitiesDelegate?
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: AbilitiesDelegate) {
        self.delegate = delegate
    }
    
    func getAbilityInfo(url: String) {
        self.delegate?.didStartLoading()
        print(url)
        service.getPokemonAbility(url: url, onSuccess: { data in
            self.delegate?.didLoadedData(data: data)
        }, onError: { error in
            self.delegate?.didReceiveError(error: error)
        })
    }
    
}

//
//  AllAbilitiesViewModel.swift
//  pokemon-db
//
//  Created by Admin on 07/07/21.
//

import Foundation
import UIKit

// MARK: - View Model

class AllAbilitiesViewModel {
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    private var completeList: AbilityList = AbilityList(count: 0, next: nil, previous: nil, results: [DefaultItem]()) {
        didSet {
            self.setAbilityList()
        }
    }
    
    var currentList: AbilityList = AbilityList(count: 0, next: nil, previous: nil, results: [DefaultItem]()) {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    let service: PokemonService
    
    var updateLoadingStatus: (() -> ())?
    var reloadCollectionView: (() -> ())?
    
    init(service: PokemonService) {
        self.service = service
    }
    
    // MARK: - Private
    
    func initFetch() {
        self.isLoading = true
        service.getAbilitiesList(completion: { result in
            self.isLoading = false
            switch result {
            case .success(let data):
                self.processFetchedData(data: data)
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    func reloadData(data: AbilityList) {
        self.completeList = data
    }
    
    private func processFetchedData(data: AbilityList) {
        self.completeList = data
    }
    
    private func setAbilityList() {
        self.currentList = self.completeList
    }
    
    
}

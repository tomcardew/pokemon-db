//
//  PokemonService.swift
//  pokemon-db
//
//  Created by Admin on 27/06/21.
//

import Foundation
import Alamofire

class PokemonService {
    
    static let shared = PokemonService()
    var previousResults: PokemonList? = nil
    var onPage = 1
    var next: String?
    var previous: String?
    
    public func getList(page: Int = 1, onSuccess: @escaping(PokemonList) -> Void, onError: @escaping(String) -> Void) {
        let url = "\(ApiBaseUrls.Pokeapi.rawValue)\(ApiPaths.Pokemon.rawValue)"
        let params = ["limit": "50", "offset": "\(50 * page)"]
        AF.request(url, parameters: params).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                print(true)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonList.self, from: response.data!)
                    self.previousResults = result
                    self.onPage = page
                    self.next = result.next
                    self.previous = result.previous
                    onSuccess(result)
                } catch {
                    onError(error.localizedDescription)
                }
            case .failure:
                onError(response.error?.errorDescription ?? "Something went wrong")
            }
        })
    }
    
    public func getPokemonData(url: String, onSuccess: @escaping(PokemonData) -> Void, onError: @escaping(String) -> Void) {
        AF.request(url).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonData.self, from: response.data!)
                    onSuccess(result)
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            case .failure:
                onError(response.error?.errorDescription ?? "Something went wrong")
            }
        })
    }
    
    public func getPokemonSpecies(url: String, onSuccess: @escaping(PokemonSpecie) -> Void, onError: @escaping(String) -> Void) {
        AF.request(url).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonSpecie.self, from: response.data!)
                    onSuccess(result)
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            case .failure:
                onError(response.error?.errorDescription ?? "Something went wrong")
            }
        })
    }
    
    public func getPokemonEvolutions(url: String, onSuccess: @escaping(PokemonEvolutionChain) -> Void, onError: @escaping(String) -> Void) {
        AF.request(url).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonEvolutionChain.self, from: response.data!)
                    debugPrint(result)
                    onSuccess(result)
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            case .failure:
                onError(response.error?.errorDescription ?? "Something went wrong")
            }
        })
    }
    
    public func getPokemonAbility(url: String, onSuccess: @escaping(PokemonAbilityDetails) -> Void, onError: @escaping(String) -> Void) {
        AF.request(url).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonAbilityDetails.self, from: response.data!)
                    debugPrint(result)
                    onSuccess(result)
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            case .failure:
                onError(response.error?.errorDescription ?? "Something went wrong")
            }
        })
    }
    
}

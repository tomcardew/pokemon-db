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
    
    public func getList(page: Int = 0, onSuccess: @escaping(PokemonList) -> Void, onError: @escaping(String) -> Void) {
        let url = "\(ApiBaseUrls.Pokeapi.rawValue)\(ApiPaths.Pokemon.rawValue)"
        let params = ["limit": "50"]
        AF.request(url, parameters: params).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                print(true)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PokemonList.self, from: response.data!)
                    self.previousResults = result
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
    
}

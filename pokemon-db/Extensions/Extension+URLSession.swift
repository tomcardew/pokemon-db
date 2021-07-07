//
//  Extension+URLSession.swift
//  pokemon-db
//
//  Created by Admin on 07/07/21.
//

import Foundation

extension URLSession {
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    /**
     Generic API request handler
     - Parameter url: URL object with the url to request
     - Parameter expecting: Data structure type of the object we are parsing from the obtained result
     - Parameter completion: Completion handler
     */
    func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        })
        
        task.resume()
    }
    
}

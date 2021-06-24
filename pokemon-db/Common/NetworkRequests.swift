//
//  NetworkRequests.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation
import Alamofire

class NetworkRequests {
    
    static let shared = NetworkRequests()
    
    public func getFeaturedNews(onSuccess: @escaping(NewsModel) -> Void
    ) {
        let url = "\(ApiBaseUrls.News.rawValue)\(ApiPaths.News.rawValue)"
        let parameters = ["q": "pokémon", "apiKey": ApiTokens.News.rawValue, "pageSize": "10", "sortBy": "publishedAt", "language": "en"]
        AF.request(url, parameters: parameters).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(NewsModel.self, from: response.data!)
                    onSuccess(result)
                } catch { debugPrint(error) }
            case .failure:
                print(response.error)
            }
        })
    }
    
}

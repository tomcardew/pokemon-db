//
//  NewsService.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import Foundation
import Alamofire

class NewsService {
    
    static let shared = NewsService()
    
    public func getFeaturedNews(onSuccess: @escaping(NewsModel) -> Void, onError: @escaping(String) -> Void) {
        let url = "\(ApiBaseUrls.News.rawValue)\(ApiPaths.News.rawValue)"
        let parameters = ["q": "pokémon", "apiKey": ApiTokens.News.rawValue, "pageSize": "10", "sortBy": "publishedAt", "language": "en"]
        AF.request(url, parameters: parameters).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(NewsModel.self, from: response.data!)
                    switch result.status {
                    case .ok:
                        onSuccess(result)
                    case .error:
                        onError(result.message ?? "Something went wrong")
                    }
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

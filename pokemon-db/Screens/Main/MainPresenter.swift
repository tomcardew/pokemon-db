//
//  MainPresenter.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import Foundation

protocol MainDelegate: NSObjectProtocol {
    func loadedFeaturedNews(news: NewsModel)
    func onError(errorMessage: String)
}

class MainPresenter {
    
    private let newsService: NewsService
    weak private var mainDelegate: MainDelegate?
    
    init(service: NewsService) {
        self.newsService = service
    }
    
    func setViewDelegate(viewDelegate: MainDelegate?) {
        self.mainDelegate = viewDelegate
    }
    
    func loadFeaturedNews() {
        newsService.getFeaturedNews(onSuccess: { results in
            self.mainDelegate?.loadedFeaturedNews(news: results)
        }, onError: { error in
            self.mainDelegate?.onError(errorMessage: error)
        })
    }
    
}

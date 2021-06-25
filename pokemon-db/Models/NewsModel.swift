//
//  NewsModel.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation

struct NewsModel: Codable {
    
    let status: Status
    let code: String?
    let message: String?
    var totalResults: Int? = 0
    let articles: [Article]?
    
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String?
}

enum Status: String, Codable {
    case ok = "ok"
    case error = "error"
}

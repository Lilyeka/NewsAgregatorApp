//
//  Article.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

struct Articles: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: ArticleSource
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    init(details: [String: Any]) {
        self.source = ArticleSource(id: "?", name: "???") // TODO - сделать правильно
        let urlToImageDict = details["enclosure"] as? [String:String] ?? ["":""]
        self.urlToImage = urlToImageDict["url"] ?? ""
        
        self.title = details["title"] as? String ?? ""
        self.description = details["description"] as? String ?? ""
        self.url = details["link"] as? String ?? ""
        self.publishedAt = details["pubDate"] as? String ?? ""
    }
}

struct ArticleSource: Decodable {
    let id: String
    let name: String
}

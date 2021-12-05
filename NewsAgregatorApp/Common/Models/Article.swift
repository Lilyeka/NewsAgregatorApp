//
//  Article.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

struct Articles: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    var source: ArticleSource
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    static func getArticle(details: [String: Any]) -> Article {
        let source = ArticleSource(id: "?", name: "???")
        let urlToImageDict = details["enclosure"] as? [String:String] ?? ["":""]
        let urlToImage = urlToImageDict["url"] ?? ""
        
        let title = details["title"] as? String ?? ""
        let description = details["description"] as? String ?? ""
        let url = details["link"] as? String ?? ""
        let publishedAt = details["pubDate"] as? String ?? ""
        
        return Article(source: source, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
    }
}

struct ArticleSource: Decodable {
    let id: String?
    let name: String
}

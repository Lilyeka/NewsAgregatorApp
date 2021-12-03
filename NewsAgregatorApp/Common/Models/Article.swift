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
    let url: URL
    let urlToImage: URL
    let publishedAt: String
}

struct ArticleSource: Decodable {
    let id: String
    let name: String
}

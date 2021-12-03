//
//  Endpoint.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

enum EndpointCases: EndpointProtocol {
    case getArticlesFromNewsApi(country: String, apiKey: String)
    
    var httpMethod: String {
        switch self {
        case .getArticlesFromNewsApi:
            return "GET"
        }
    }
    
    var baseURLString: String {
        switch self {
        case .getArticlesFromNewsApi:
            return "https://newsapi.org/"
        }
    }
    
    var path: String {
        switch self {
        case .getArticlesFromNewsApi:
            return "v2/top-headlines"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getArticlesFromNewsApi(let country, let apiKey):
            return ["country": country,
                    "apiKey": apiKey
                    ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getArticlesFromNewsApi:
            return [:]
        }
    }
}

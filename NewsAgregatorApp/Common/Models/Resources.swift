//
//  Resources.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//

import Foundation

protocol ResourcesProtocol {
    func getResourceEndpoint() -> EndpointProtocol
}

enum Resources: String, Codable, ResourcesProtocol {
    case lenta = "Lenta.ru"
    case gazeta = "Gazeta.ru"
    case newsapi = "Newsapi.org"
    
    func getResourceEndpoint() -> EndpointProtocol {
        var endpoint: EndpointProtocol
        switch self {
        case .lenta:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://lenta.ru",
                                path: "/rss",
                                urlQueryItems: nil)
        case .gazeta:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://www.gazeta.ru",
                                path: "/export/rss/lenta.xml",
                                urlQueryItems: nil)
        case .newsapi:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://newsapi.org/v2",
                                path: "/top-headlines",
                                urlQueryItems: [
                                    (name: "country", value: "ru"),
                                    (name: "apiKey", value: Constants.newsApiOrgKey)
                                ])
        }
        return endpoint
    }
    
    func getResourceParser() -> ParserProtocol {
        var parser: ParserProtocol = XMLParserSevice()
        if self == .newsapi {
            parser = JSONParserSevice()
        }
        return parser
    }
}

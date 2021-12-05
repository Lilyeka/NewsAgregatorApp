//
//  Endpoint.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

enum EndpointCases {
    static func newsApiEndpoint(country: String, apiKey: String) -> EndpointProtocol {
        return Endpoint(httpMethod: "GET",
                        baseURLString: "https://newsapi.org/v2",
                        path: "/top-headlines",
                        urlQueryItems: [
                            (name: "country", value: "ru"),
                            (name: "apiKey", value: Constants.newsApiOrgKey)
                        ])
    }
    
    static func lentaApiEndpoint() -> EndpointProtocol {
        return Endpoint(httpMethod: "GET",
                        baseURLString: "https://lenta.ru",
                        path: "/rss",
                        urlQueryItems: nil)
    }
    
    static func gazetaApiEndpoint() -> EndpointProtocol {
        return Endpoint(httpMethod: "GET",
                        baseURLString: "https://www.gazeta.ru",
                        path: "/export/rss/lenta.xml",
                        urlQueryItems: nil)
    }
}

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
                        headers: [:], //["country": country,
                                 // "apiKey": apiKey],
                        body: [:])
    }
    
}

//
//  Endpoint.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

protocol EndpointProtocol {
    var httpMethod: String { get }
    var baseURLString: String { get }
    var path: String { get }
    var urlQueryItems: [(name: String, value:String)]? { get }
}

extension EndpointProtocol {
    var url: String {
        return baseURLString + path
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else { return nil }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard var urlComponents = components else {
            return nil
        }
        
        if let urlQueryItems = self.urlQueryItems {
            var queryItems = [URLQueryItem]()
            urlQueryItems.forEach { name, value in
                let newQueryItem = URLQueryItem(name: name, value: value)
                queryItems.append(newQueryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let finalUrl = urlComponents.url else { return nil }
        
        return URLRequest(url: finalUrl)
    }
}

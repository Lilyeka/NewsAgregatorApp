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
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension EndpointProtocol {
    var url: String {
        return baseURLString + path
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else { return nil }
        var urlRequest = URLRequest(url: url)
   
        urlRequest.httpMethod = self.httpMethod

        self.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        return urlRequest
    }

}

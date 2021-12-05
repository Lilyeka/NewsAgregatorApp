//
//  Endpoint.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

struct Endpoint: EndpointProtocol {
    var httpMethod: String
    var baseURLString: String
    var path: String
    var urlQueryItems: [(name: String, value: String)]?
}

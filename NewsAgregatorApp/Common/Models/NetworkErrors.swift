//
//  NetworkErrors.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

enum NetworkErrors: Error {
    case requestCreation
    case server(Error)
    case unknown
    
    var description: String {
        switch self {
        case .requestCreation:
            return "URL request creation error"
        case .server:
            return "Server side error"
        case .unknown:
            return "Unknown error"
        }
    }
}

enum CustomErrors: Error {
    case parseDataError
    
    var description: String {
        switch self {
        case .parseDataError:
            return "Wrong parse data"
        }
    }
}


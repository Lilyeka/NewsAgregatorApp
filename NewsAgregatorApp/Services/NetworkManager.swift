//
//  NetworkManager.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

protocol NetworkingProtocol {
    func request(_ endPoint: EndpointProtocol, completion: @escaping
                 ((Result<Data,NetworkErrors>) -> Void))
}

public class NetworkManager: NetworkingProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(_ endPoint: EndpointProtocol, completion: @escaping
    ((Result<Data,NetworkErrors>) -> Void)) {
        
        guard let request = endPoint.urlRequest else {
            completion(.failure(NetworkErrors.requestCreation))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            let result: Result<Data, NetworkErrors>
            if let error = error {
                result = .failure(NetworkErrors.server(error))
            } else if let data = data {
                result = .success(data)
            } else {
                result = .failure(NetworkErrors.unknown)
            }
            completion(result)
        }.resume()
        
    }
}

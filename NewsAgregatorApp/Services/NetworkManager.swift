//
//  NetworkManager.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

enum ResponseDataTypes: String {
    case xml
    case json
    
    static func getCaseForString(string: String) -> ResponseDataTypes {
        return string.contains("xml") ? .xml : .json
    }
}

protocol NetworkingProtocol {
    func request(_ endPoint: EndpointProtocol, completion: @escaping
                 ((Result<(Data,ResponseDataTypes),NetworkErrors>) -> Void))
}

public class NetworkManager: NetworkingProtocol {
    

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(_ endPoint: EndpointProtocol, completion: @escaping
    ((Result<(Data,ResponseDataTypes),NetworkErrors>) -> Void)) {
        
        guard let request = endPoint.urlRequest else {
            completion(.failure(NetworkErrors.requestCreation))
            return
        }
      
        session.dataTask(with: request) { data, response, error in
            var result: Result<(Data,ResponseDataTypes), NetworkErrors>
            if let error = error {
                result = .failure(NetworkErrors.server(error))
            } else if let data = data {
                if let mimeType = response?.mimeType {
                    let dataType = ResponseDataTypes.getCaseForString(string: mimeType)
                    result = .success((data,dataType))
                } else {
                    result = .failure(NetworkErrors.unknown)
                }
            } else {
                result = .failure(NetworkErrors.unknown)
            }
            completion(result)
        }.resume()
        
    }
}

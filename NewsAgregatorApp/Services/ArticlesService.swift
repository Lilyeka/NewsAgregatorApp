//
//  ArticlesService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

class ArticlesService {
    
    let networkManager: NetworkingProtocol
    let translationLayer = JSONDecoder()
    
    init(networkManager: NetworkingProtocol) {
        self.networkManager = networkManager
    }
    
    func getArticles(endpoint: EndpointProtocol, completion: @escaping (Articles?, Error?) -> Void) {
     
        networkManager.request(endpoint) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    print(String(data: data, encoding: .utf8)!)
                    let parseData = try self?.translationLayer.decode(Articles.self, from: data)
                    completion(parseData,nil)
                } catch {
                    completion(nil, CustomErrors.parseDataError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

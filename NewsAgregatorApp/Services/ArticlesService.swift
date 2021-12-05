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
    
    func getArticles(from country: String, completion: @escaping (Articles?, Error?) -> Void) {
        let endpoint = EndpointCases.newsApiEndpoint(country: country, apiKey: Constants.newsApiOrgKey)
        
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
        
        //        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=087de7644b8849b0a996d0271bf15814")!
        //
        //        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        //            guard let data = data else { return }
        //            print(String(data: data, encoding: .utf8)!)
        //        }
        //        task.resume()
    }
}

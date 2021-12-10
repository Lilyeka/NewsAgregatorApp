//
//  ArticlesService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

protocol ArticlesServiceProtocol {
    func getArticles(endpoints: [(Resources, EndpointProtocol, ParserProtocol)], completion: @escaping (Articles?, Error?) -> Void)
}

class ArticlesService: ArticlesServiceProtocol {
    
    let networkManager: NetworkingProtocol
    
    init(networkManager: NetworkingProtocol) {
        self.networkManager = networkManager
    }
    
    func getArticles(endpoints: [(Resources, EndpointProtocol, ParserProtocol)], completion: @escaping (Articles?, Error?) -> Void) {
        var totalArticles = [Article]()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        if !endpoints.isEmpty {
            endpoints.forEach { (resource, endpoint, parser) in
                group.enter()
                self.networkManager.request(endpoint) { result in
                    switch result {
                    case .success(let data):
                        parser.parseData(data: data) { articles in
                            semaphore.wait()
                            if !articles.isEmpty {
                                var articlesCopy = articles
                                for index in articlesCopy.indices {
                                    articlesCopy[index].resource = resource
                                }
                                totalArticles.append(contentsOf: articlesCopy)
                            }
                            semaphore.signal()
                            group.leave()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            group.notify(queue: DispatchQueue.global()) {
                completion(Articles(status: "", totalResults: 0, articles: totalArticles), nil)
            }
        }
    }
}

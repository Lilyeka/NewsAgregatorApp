//
//  ArticlesService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

protocol ArticlesServiceProtocol {
    func getArticles(endpoints: [(Resources)], completion: @escaping (Articles?, Error?) -> Void)
}

class ArticlesService: ArticlesServiceProtocol {
    
    let networkManager: NetworkingProtocol
    let readMarksService: ReadUrlsServiceProtocol
    
    init(networkManager: NetworkingProtocol, readMarksService: ReadUrlsServiceProtocol) {
        self.networkManager = networkManager
        self.readMarksService = readMarksService
    }
    
    func getArticles(endpoints: [(Resources)], completion: @escaping (Articles?, Error?) -> Void) {
        let readMarksModel = readMarksService.getReadUrls()
        var totalArticles = [Article]()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        if !endpoints.isEmpty {
            endpoints.forEach { resource in
                group.enter()
                let endpoint = resource.getResourceEndpoint()
                self.networkManager.request(endpoint) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        let parser = resource.getResourceParser()
                        parser.parseData(data: data) { articles in
                            semaphore.wait()
                            if !articles.isEmpty {
                                totalArticles.append(contentsOf: self.setResources(articles: articles, resource: resource))
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
    
    fileprivate func setResources(articles: [Article], resource: Resources) -> [Article] {
        var articlesCopy = articles
        for index in articlesCopy.indices {
            articlesCopy[index].resource = resource
//            guard let url = articlesCopy[index].url,
//                  let _ = readMarkModel.firstIndex(resource: resource, value: url) else { continue }
//            articlesCopy[index].readMark = true
        }
        return articlesCopy
    }
}

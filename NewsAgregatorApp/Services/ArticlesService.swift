//
//  ArticlesService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

protocol ArticlesServiceProtocol {
    func getArticles(endpoints: [EndpointProtocol], completion: @escaping (Articles?, Error?) -> Void)
}

class ArticlesService: ArticlesServiceProtocol {
    
    let networkManager: NetworkingProtocol
    let jsonParser: JSONDecoder
    let xmlParser: XMLParserProtocol
    
    init(networkManager: NetworkingProtocol, xmlParser: XMLParserProtocol, jsonParser: JSONDecoder) {
        self.networkManager = networkManager
        self.xmlParser = xmlParser
        self.jsonParser = jsonParser
    }
    
    func getArticles(endpoints: [EndpointProtocol], completion: @escaping (Articles?, Error?) -> Void) {
        var totalArticles = [Article]()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        if !endpoints.isEmpty {
            endpoints.forEach { endpoint in
                group.enter()
                self.networkManager.request(endpoint) { [weak self] result in
                    switch result {
                    case .success(let dataAndType):
                        self?.parse(data: dataAndType.0, dataType: dataAndType.1, completion: { [weak self] articles in
                            if !articles.isEmpty {
                                semaphore.wait()
                                totalArticles.append(contentsOf: articles)
                                semaphore.signal()
                                group.leave()
                             }
                        })
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
    
    fileprivate func parse(data: Data, dataType: ResponseDataTypes, completion: @escaping ([Article]) -> Void) {
        switch dataType {
        case .xml:
            self.xmlParser.parseData(data: data) { articles in
                completion(articles)
            }
        case .json:
            do {
                print(String(data: data, encoding: .utf8)!)
                let parseData = try self.jsonParser.decode(Articles.self, from: data)
                completion(parseData.articles)
            } catch {
                print(CustomErrors.parseDataError)
                completion([Article]())
            }
        }
    }
}

//
//  JSONParserService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

class JSONParserSevice: NSObject, ParserProtocol {
    
    func parseData(data: Data, completion: @escaping (([Article]) -> Void)) {
        let jsonDecoder = JSONDecoder()
        do {
            let parseData = try jsonDecoder.decode(Articles.self, from: data)
            completion(parseData.articles)
        } catch {
            completion([Article]())
        }
    }
}

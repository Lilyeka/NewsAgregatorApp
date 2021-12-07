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
            if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
               print(jsonString)
            }
            let parseData = try jsonDecoder.decode(Articles.self, from: data)
            completion(parseData.articles)
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
            completion([Article]())
        } catch DecodingError.keyNotFound(let key, let context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
            completion([Article]())
        } catch DecodingError.typeMismatch(let type, let context) {
            print("\(type) was expected, \(context.debugDescription)")
            completion([Article]())
        } catch DecodingError.valueNotFound(let type, let context) {
            print("no value was found for \(type), \(context.debugDescription)")
            completion([Article]())
        } catch {
            print("I know not this decoding error")
            completion([Article]())
        }
    }
}

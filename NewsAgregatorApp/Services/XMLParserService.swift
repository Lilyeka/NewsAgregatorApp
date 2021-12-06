//
//  ParcerService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

protocol ParserProtocol {
    func parseData(data: Data, completion: @escaping(([Article]) -> Void))
}

class XMLParserSevice: NSObject, ParserProtocol {
    private var parseCompletion: (([Article]) -> Void)?
    private var xmlDict = [String: Any]()
    private var xmlDictArr = [[String: Any]]()
    private var currentElement = ""
    private var currentElementText = ""
    private var currentAttributeDict: [String : String] = [:]
    private var articles: Array<Article> = [Article]()
    
    func parseData(data: Data, completion: @escaping
                   (([Article]) -> Void)) {
        self.parseCompletion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    private func parsingCompleted() {
        DispatchQueue.global().async {
            self.articles = self.xmlDictArr.map { Article.getArticle(details: $0) }
            self.parseCompletion?(self.articles)
        }
    }
}

extension XMLParserSevice: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
            currentElementText = ""
        } else {
            currentElement = elementName
            currentAttributeDict = attributeDict
            currentElementText = ""
            if !currentAttributeDict.isEmpty {
                xmlDict.updateValue(currentAttributeDict, forKey: currentElement)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let parsString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !parsString.isEmpty {
            currentElementText += parsString
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
        } else {
            if xmlDict[currentElement] == nil {
                xmlDict.updateValue(currentElementText, forKey: currentElement)
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parsingCompleted()
    }
}


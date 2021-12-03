//
//  ParcerService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import Foundation

class ParserSevice: NSObject, XMLParserDelegate {
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var currentAttributeDict: [String : String] = [:]
    var articles: Array<Article> = [Article]()
    var parseCompletion: (([Article]) -> Void)?
    
    func parceData(data: Data, completion: @escaping
                   (([Article]) -> Void)) {
        self.parseCompletion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
        } else {
            currentElement = elementName
            currentAttributeDict = attributeDict
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if xmlDict[currentElement] == nil {
            if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                xmlDict.updateValue(string, forKey: currentElement)
            } else if !currentAttributeDict.isEmpty{
                xmlDict.updateValue(currentAttributeDict, forKey: currentElement)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parsingCompleted()
    }
    
    func parsingCompleted() {
        DispatchQueue.global().async {
            self.articles = self.xmlDictArr.map { Article(details: $0) }
            self.parseCompletion?(self.articles)
        }
            
    }
}


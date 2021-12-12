//
//  ReadUrls.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 10.12.2021.
//

import Foundation

class ReadUrls: Codable {
    var urls: [ Resources : [String] ] = [.gazeta : ["1testUrl"] ]
    
    func firstIndex(resource: Resources, value: String) -> Int? {
        guard let valuesArray = self.urls[resource] else {
            return nil
        }
        return valuesArray.firstIndex(of: value)
    }
    
    func addNewValue(resource: Resources, value: String) {
        if self.firstIndex(resource: resource, value: value) == nil {
            if self.urls[resource] != nil {
                self.urls[resource]?.append(value)
            } else {
                self.urls[resource] = [value]
            }
        }
    }
    
    func removeValue(resource: Resources, value: String) {
        guard let index = self.firstIndex(resource: resource, value: value),
            var valuesArray = self.urls[resource] else { return }
        valuesArray.remove(at: index)
        if valuesArray.isEmpty {
            self.urls[resource] = nil
        }
    }
}

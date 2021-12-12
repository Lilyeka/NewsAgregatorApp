//
//  ReadUrlsService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 11.12.2021.
//

import Foundation

protocol ReadUrlsServiceProtocol {
    func getReadUrls() -> ReadUrls
    func setAsRead(resource: Resources, url: String)
    func removeAsRead(resource: Resources, url: String)
}

class ReadUrlsService: ReadUrlsServiceProtocol {
    
    var userDefaultsService: UserDefaultsManagerProtocol = UserDefaultsManager(userDefaults: UserDefaults.standard)
    
    func getReadUrls() -> ReadUrls {
        var readUrlsModel = ReadUrls()
        if let readUrls = userDefaultsService.readValue(type: ReadUrls.self, forKey: .readMarks) {
            readUrlsModel = readUrls
        }
        return readUrlsModel
    }
    
    func setAsRead(resource: Resources, url: String) {
        let readUrlsModel = getReadUrls()
        readUrlsModel.addNewValue(resource: resource, value: url)
        userDefaultsService.archiveValue(forKey: .readMarks, value: readUrlsModel)
    }
    
    func removeAsRead(resource: Resources, url: String) {
        let readUrlsModel = getReadUrls()
        readUrlsModel.removeValue(resource: resource, value: url)
        userDefaultsService.archiveValue(forKey: .readMarks, value: readUrlsModel)
    }
}

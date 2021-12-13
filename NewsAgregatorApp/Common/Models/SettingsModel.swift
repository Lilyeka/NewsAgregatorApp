//
//  SettingsModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

struct ShowResources: Codable {
    var resource: Resources
    var isActive: Bool
}

class SettingsModel: Codable {
    var mode: ShowModes
    var resourses: [ShowResources]
    var updatingInterval: Int
    
    init(mode: ShowModes, resourses: [ShowResources], updatingInterval: Int) {
        self.mode = mode
        self.resourses = resourses
        self.updatingInterval = updatingInterval
    }
        
    func getActiveResources() -> [Resources]? {
        return self.resourses.filter{ $0.isActive }.map{ $0.resource }
    }
    
    func changeActiveStateForResource(index:Int, isActive: Bool) {
        if index < self.resourses.count {
            self.resourses[index].isActive = isActive
        }
    }
    
    func changeShowMode(modeIndex: Int) {
        if modeIndex < ShowModes.allCases.count {
            let mode = ShowModes.allCases[modeIndex]
            self.mode = mode
        }
    }
}

enum ShowModes: String, CaseIterable, Codable {
    case normalMode = "Обычный"
    case extentMode = "Расширенный"
    
    func isExtendedMode() -> Bool {
        return self == .extentMode ? true : false
    }
}

protocol ResourcesProtocol {
    func getResourceEndpoint() -> EndpointProtocol
}

enum Resources: String, Codable, ResourcesProtocol {
    case lenta = "Lenta.ru"
    case gazeta = "Gazeta.ru"
    case newsapi = "Newsapi.org"
    
    func getResourceEndpoint() -> EndpointProtocol {
        var endpoint: EndpointProtocol
        switch self {
        case .lenta:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://lenta.ru",
                                path: "/rss",
                                urlQueryItems: nil)
        case .gazeta:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://www.gazeta.ru",
                                path: "/export/rss/lenta.xml",
                                urlQueryItems: nil)
        case .newsapi:
            endpoint = Endpoint(httpMethod: "GET",
                                baseURLString: "https://newsapi.org/v2",
                                path: "/top-headlines",
                                urlQueryItems: [
                                    (name: "country", value: "ru"),
                                    (name: "apiKey", value: Constants.newsApiOrgKey)
                                ])
        }
        return endpoint
    }
    
    func getResourceParser() -> ParserProtocol {
        var parser: ParserProtocol = XMLParserSevice()
        if self == .newsapi {
            parser = JSONParserSevice()
        }
        return parser
    }
}


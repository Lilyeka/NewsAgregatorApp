//
//  SettingsService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

protocol SettingsServiceProtocol {
    //TODO убрать set оставить только get
    var currentSettings: SettingsModel? { get set }
    
    func getSettingsInfo()
    func changeSettingsInfo(resourceIndex:Int, isActive: Bool)
    func getEndpointsAndParsers() -> [(EndpointProtocol,ParserProtocol)]?
}

class SettingsService: SettingsServiceProtocol {
    
    static let shared: SettingsServiceProtocol = SettingsService(settings: nil)
    
    var currentSettings: SettingsModel?
    
    private init(settings: SettingsModel?) {
        self.currentSettings = settings
    }
    
    func getSettingsInfo() {
        
        let resourses: [ShowResources] = [
            (resource: .lenta, isActive: true),
            (resource: .gazeta, isActive: true),
            (resource: .newsapi, isActive: true)
        ]
        
        self.currentSettings = SettingsModel(mode: .extentMode,
                                             resourses :resourses)
    }
    
    func getEndpointsAndParsers() -> [(EndpointProtocol,ParserProtocol)]? {
        let endpoints = self.currentSettings?.resourses.map({ resource in
            return ( resource.resource.getResourceEndPoint(),
                     resource.resource.getResourceParser())
        })
        return endpoints
    }
    
    func changeSettingsInfo(resourceIndex:Int, isActive: Bool) {
        var resource = self.currentSettings?.resourses[resourceIndex]
        resource?.isActive = isActive
    }
    
}

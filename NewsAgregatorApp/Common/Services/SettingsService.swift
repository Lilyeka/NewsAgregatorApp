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
    //TODO:
    // избавиться от синглтона, заменить на нотификейшн ценрт (оповещение обю изменениях модели настроек будет приходить в эркна настроек, экран списка и таймер обновления)
    static let shared: SettingsServiceProtocol = SettingsService(settings: nil)
    
    var currentSettings: SettingsModel?
    
    private init(settings: SettingsModel?) {
        self.currentSettings = settings
    }
    
    func getSettingsInfo() {
        if  self.currentSettings == nil {
            let resourses: [ShowResources] = [
                ShowResources(resource: .lenta, isActive: true),
                ShowResources(resource: .gazeta, isActive: true),
                ShowResources(resource: .newsapi, isActive: true)
            ]
            
            self.currentSettings = SettingsModel(mode: .extentMode,
                                                 resourses :resourses,
                                                 updatingRate: 1)
        }
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

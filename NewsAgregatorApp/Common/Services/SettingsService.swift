//
//  SettingsService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

protocol SettingsServiceProtocol {
    func getSettingsInfo() -> SettingsModel
    func saveSettingsInfo(model: SettingsModel)
}

class SettingsService: SettingsServiceProtocol {

    var userDefaultsService: UserDefaultsManagerProtocol
  
    init(userDefaultsService: UserDefaultsManagerProtocol) {
        self.userDefaultsService = userDefaultsService
    }
    
    func getSettingsInfo() -> SettingsModel {
        if let settings = self.getSavedSettingsInfo() {
            return settings
        } else {
            let settings = getDefaultSettingsInfo()
            self.saveSettingsInfo(model: settings)
            return settings
        }
    }
    
    func saveSettingsInfo(model: SettingsModel) {
        self.userDefaultsService.archiveValue(forKey: .settingsModel, value: model)
    }
    
    fileprivate func getSavedSettingsInfo() -> SettingsModel? {
        guard let model = self.userDefaultsService.readValue(type: SettingsModel.self, forKey: .settingsModel)
        else { return nil }
        return model
    }
    
    fileprivate func getDefaultSettingsInfo() -> SettingsModel {
        let resourses: [ShowResources] = [
            ShowResources(resource: .lenta, isActive: true),
            ShowResources(resource: .gazeta, isActive: true),
            ShowResources(resource: .newsapi, isActive: true)
        ]
        
        return SettingsModel(mode: .extentMode,
                             resourses :resourses,
                             updatingInterval: 300)
    }
}

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
    
    func getSettingsInfo() -> SettingsModel
    func saveSettingsInfo(model: SettingsModel)
}

class SettingsService: SettingsServiceProtocol {
    
    
    //TODO:
    // избавиться от синглтона, заменить на нотификейшн ценрт (оповещение обю изменениях модели настроек будет приходить в эркна настроек, экран списка и таймер обновления)
    static let shared: SettingsServiceProtocol = SettingsService(settings: nil)
    
    var userDefaultsService: UserDefaultsManagerProtocol = UserDefaultsManager(userDefaults: UserDefaults.standard)
    
    var currentSettings: SettingsModel?
    
    private init(settings: SettingsModel?) {
        self.currentSettings = settings
    }
    
    func getSettingsInfo() -> SettingsModel {
        if let settings = userDefaultsService.readValue(type: SettingsModel.self, forKey: .settingsModel) {
            self.currentSettings = settings
        } else {
            self.currentSettings = getDefaultSettingsInfo()
            if let curSet = self.currentSettings {
                self.saveSettingsInfo(model: curSet)
            }
        }
        return self.currentSettings ?? getDefaultSettingsInfo()
    }
    
    func saveSettingsInfo(model: SettingsModel) {
        self.userDefaultsService.setValue(forKey: .settingsModel, value: model)
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
                             updatingRate: 1)
    }
}

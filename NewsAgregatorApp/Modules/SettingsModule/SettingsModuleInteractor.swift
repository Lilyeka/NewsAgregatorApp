//
//  SettingsModuleInteractor.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

protocol SettingsModuleInteractorInput {
    func getSettings()
}

protocol SettingsModuleInteractorOutput: AnyObject {
    func settingsRecieved(settings: SettingsModel)
}

class SettingsModuleInteractor: SettingsModuleInteractorInput {
    
    let settingsService: SettingsServiceProtocol = SettingsService.shared

    weak var presenter: SettingsModuleInteractorOutput?
    
    func getSettings() {
        settingsService.getSettingsInfo()
        guard let settings = settingsService.currentSettings else {
            return
        }
        presenter?.settingsRecieved(settings: settings)
    }
    
    
}

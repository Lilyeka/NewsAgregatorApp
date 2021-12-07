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
    func settingsRecieved(settings: SettingsViewModel)
}

class SettingsModuleInteractor: SettingsModuleInteractorInput {
    
    let settingsService: SettingsServiceProtocol = SettingsService.shared
    
    let viewModelsBuilder: SettingsViewModelBuilderProtocol = SettingsViewModelBuilder()

    weak var presenter: SettingsModuleInteractorOutput?
    
    func getSettings() {
        settingsService.getSettingsInfo()
        guard let settings = settingsService.currentSettings else {
            return
        }
        let viewModel = self.viewModelsBuilder.getSettingsViewModel(settings: settings)
        presenter?.settingsRecieved(settings: viewModel)
    }
}

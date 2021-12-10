//
//  SettingsModuleInteractor.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

protocol SettingsModuleInteractorInput {
    func getSettings()
    func setResourceActiveState(index:Int, isActive: Bool)
    func setArticlesShowMode(modeIndex:Int)
}

protocol SettingsModuleInteractorOutput: AnyObject {
    func settingsRecieved(settings: SettingsViewModel)
}

class SettingsModuleInteractor: SettingsModuleInteractorInput {
    
    var settingsService: SettingsServiceProtocol
    let viewModelsBuilder: SettingsViewModelBuilderProtocol
    
    weak var presenter: SettingsModuleInteractorOutput?
    
    var settingsModel: SettingsModel?
    
    init(settingsService: SettingsServiceProtocol, viewModelsBuilder: SettingsViewModelBuilderProtocol) {
        self.settingsService = settingsService
        self.viewModelsBuilder = viewModelsBuilder
    }
    
    func getSettings() {
        self.settingsModel = self.settingsService.getSettingsInfo()
        guard let settings = self.settingsModel else { return }
        let viewModel = self.viewModelsBuilder.getSettingsViewModel(settings: settings)
        self.presenter?.settingsRecieved(settings: viewModel)
    }
    
    func setResourceActiveState(index:Int, isActive: Bool) {
        guard let settings = self.settingsModel else { return }
        settings.changeActiveStateForResource(index: index, isActive: isActive)
        self.settingsService.saveSettingsInfo(model: settings)
    }
    
    func setArticlesShowMode(modeIndex: Int) {
        guard let settings = self.settingsModel else { return }
        settings.changeShowMode(modeIndex: modeIndex)
        self.settingsService.saveSettingsInfo(model: settings)
    }
}

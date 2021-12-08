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
    
    var settingsService: SettingsServiceProtocol = SettingsService.shared
    var userDefaultsService: UserDefaultsManagerProtocol = UserDefaultsManager(userDefaults: UserDefaults.standard)
    
    let viewModelsBuilder: SettingsViewModelBuilderProtocol = SettingsViewModelBuilder()
    
    weak var presenter: SettingsModuleInteractorOutput?
    
    func getSettings() {
        self.settingsService.getSettingsInfo()
        guard let settings = settingsService.currentSettings else { return }
        let viewModel = self.viewModelsBuilder.getSettingsViewModel(settings: settings)
        self.presenter?.settingsRecieved(settings: viewModel)
    }
    
    func setResourceActiveState(index:Int, isActive: Bool) {
        self.settingsService.currentSettings?.resourses[index].isActive = isActive
        self.userDefaultsService.encodeValue(forKey: .settingsModel, value: self.settingsService.currentSettings)
    }
    
    func setArticlesShowMode(modeIndex: Int) {
        let mode = ShowModes.allCases[modeIndex]
        self.settingsService.currentSettings?.mode = mode
        self.userDefaultsService.encodeValue(forKey: .settingsModel, value: self.settingsService.currentSettings)
    }
}

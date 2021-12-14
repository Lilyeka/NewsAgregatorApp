//
//  ListModuleInteractorAssembly.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//

import UIKit

enum ListModuleInteractorAssembly {
    static func create() -> ListModuleInteractor {
        let listViewModelBuilder: ListViewModelBuilderProtocol = ListViewModelBuilder()
        let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager(), readMarksService: ReadUrlsService())
        let settingsService: SettingsServiceProtocol = SettingsService(userDefaultsService: UserDefaultsManager(userDefaults: UserDefaults.standard))
        let userDefaultsService: UserDefaultsManagerProtocol = UserDefaultsManager(userDefaults: UserDefaults.standard)
        let readUrlsService: ReadUrlsServiceProtocol = ReadUrlsService()
        
        let interactor = ListModuleInteractor(
            listViewModelBuilder: listViewModelBuilder,
            articleService: articleService,
            settingsService: settingsService,
            readUrlsService: readUrlsService,
            userDefaultsService: userDefaultsService)
        
        return interactor
    }

}

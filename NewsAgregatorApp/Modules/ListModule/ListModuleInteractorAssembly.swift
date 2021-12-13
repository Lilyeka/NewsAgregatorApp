//
//  ListModuleInteractorAssembly.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//

import UIKit

enum ListModuleInteractorAssembly {
    static func create() -> ListModuleInteractor {
        var listViewModelBuilder: ListViewModelBuilderProtocol = ListViewModelBuilder()
        var articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager(), readMarksService: ReadUrlsService())
        var settingsService: SettingsServiceProtocol = SettingsService(userDefaultsService: UserDefaultsManager(userDefaults: UserDefaults.standard))
        var userDefaultsService: UserDefaultsManagerProtocol = UserDefaultsManager(userDefaults: UserDefaults.standard)
        var readUrlsService: ReadUrlsServiceProtocol = ReadUrlsService()
        
        let interactor = ListModuleInteractor(
            listViewModelBuilder: listViewModelBuilder,
            articleService: articleService,
            settingsService: settingsService,
            readUrlsService: readUrlsService,
            userDefaultsService: userDefaultsService)
        
        return interactor
    }

}

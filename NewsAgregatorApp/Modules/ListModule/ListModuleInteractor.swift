//
//  ListInteractorProtocol.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

protocol ListModuleInteractorInput: NSObject {
    func getSettings()
    func getListModels()
}

protocol ListModuleInteractorOutput: NSObject {
    func listItemsRecieved(_ listItems: [ListViewModel])
    func settingsRecieved(_ settings: SettingsModel)
}

class ListModuleInteractor: NSObject, ListModuleInteractorInput {
    
    weak var presenter: ListModuleInteractorOutput?
    //TODO - сделать ListModuleInteractorAssembly c функцией create() и в ней инитить интерактор со всеми его зависимостями
    
    let listViewModelBuilder: ListViewModelBuilderProtocol = ListViewModelBuilder()
    
    let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager())
    
    let settingsService: SettingsServiceProtocol = SettingsService.shared
    
    func getSettings() {
        settingsService.getSettingsInfo()
        guard let settingsModel = settingsService.currentSettings else { return }
        self.presenter?.settingsRecieved(settingsModel)
    }
    
    func getListModels() {
        guard let endpoints = settingsService.getEndpointsAndParsers() else { return }
        articleService.getArticles(endpoints: endpoints) { [weak self] articles, error in
            if let strongSelf = self {
                let listViewModels = articles?.articles.map {
                    strongSelf.listViewModelBuilder.getViewModel(from: $0)
                }
                guard let listViewModels = listViewModels else { return }
                DispatchQueue.main.async {
                    strongSelf.presenter?.listItemsRecieved(listViewModels)
                }
            }
        }
    }
}

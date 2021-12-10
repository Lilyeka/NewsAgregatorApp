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
    func markAsRead(url: URL, index: Int)
}

protocol ListModuleInteractorOutput: NSObject {
    func listItemsRecieved(_ listItems: [ListViewModel])
    func settingsRecieved(_ settings: SettingsModel)
    func listItemsMarkedAsRread(viewModel: ListViewModel, index: Int)
}

class ListModuleInteractor: NSObject, ListModuleInteractorInput {
    
    weak var presenter: ListModuleInteractorOutput?
    //TODO - сделать ListModuleInteractorAssembly c функцией create() и в ней инитить интерактор со всеми его зависимостями
    
    let listViewModelBuilder: ListViewModelBuilderProtocol = ListViewModelBuilder()
    
    let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager())
    
    let settingsService: SettingsServiceProtocol = SettingsService.shared
    
    var articlesDictionary: Dictionary<String, ListViewModel>?
    
    func getSettings() {
        self.settingsService.getSettingsInfo()
        guard let settingsModel = settingsService.currentSettings else { return }
        self.presenter?.settingsRecieved(settingsModel)
    }
    
    func getListModels() {
        guard let settingsModel = settingsService.currentSettings,
              let endpoints = settingsModel.getEndpointsAndParsers() else { return }
        articleService.getArticles(endpoints: endpoints) { [weak self] articles, error in
            guard let strongSelf = self else { return }
      
            let listViewModels = articles?.articles.map {
                strongSelf.listViewModelBuilder.getViewModel(from: $0)
            }
            guard let listViewModels = listViewModels else { return }
            
            var dict = [String:ListViewModel]()
            listViewModels.forEach({ article in
                dict[article.url] = article
            })
            strongSelf.articlesDictionary = dict
            
            DispatchQueue.main.async {
                strongSelf.presenter?.listItemsRecieved( listViewModels)
            }
        }
    }
    
    func markAsRead(url: URL, index: Int) {
        guard let dict = self.articlesDictionary,
              var article = dict[url.absoluteString] else { return }
        article.hasBeenRead = true
        self.presenter?.listItemsMarkedAsRread(viewModel: article, index: index)
    }
}

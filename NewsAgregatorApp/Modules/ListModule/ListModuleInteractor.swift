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
    func listItemsMarkedAsRead(viewModel: ListViewModel, index: Int)
}

class ListModuleInteractor: NSObject, ListModuleInteractorInput {
    
    weak var presenter: ListModuleInteractorOutput?
    //TODO - сделать ListModuleInteractorAssembly c функцией create() и в ней инитить интерактор со всеми его зависимостями
    
    let listViewModelBuilder: ListViewModelBuilderProtocol = ListViewModelBuilder()
    
    let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager(), readMarksService: ReadUrlsService())
    
    let settingsService: SettingsServiceProtocol = SettingsService.shared
    
    let userDefaultsService: UserDefaultsManager = UserDefaultsManager(userDefaults: UserDefaults.standard)
    
    let readUrlsService: ReadUrlsServiceProtocol = ReadUrlsService()
    
    var articlesDictionary: Dictionary<String, Article>?
    var articlesArray: [Article]?
    
    var settingsModel: SettingsModel?
    
    func getSettings() {
        self.settingsService.getSettingsInfo()
        guard let settingsModel = settingsService.currentSettings else { return }
        self.settingsModel = settingsModel
        self.presenter?.settingsRecieved(settingsModel)
    }
    
    func getListModels() {
        guard let settingsModel = settingsService.currentSettings,
              let resources = settingsModel.getActiveResources() else { return }
       
        articleService.getArticles(endpoints: resources) { [weak self] articles, error in
            guard let self = self,
                  let articlesArray = articles?.articles else { return }
            self.buildArticlesDictionary(articles: articlesArray)
            
            self.cleanNotActualReadMarks(settings: settingsModel, articles: articlesArray)
            let readMarksModel = self.readUrlsService.getReadUrls()
            
            DispatchQueue.main.async {
                self.presenter?.listItemsRecieved(self.buildListViewModels(articles: articlesArray, readMarksModel: readMarksModel))
            }
        }
    }
    
    func markAsRead(url: URL, index: Int) {
        guard let dict = self.articlesDictionary,
              let article = dict[url.absoluteString],
              let resource = article.resource else { return }
        
        ReadUrlsService().setAsRead(resource: resource, url: url.absoluteString)
        
        self.presenter?.listItemsMarkedAsRead(viewModel: self.listViewModelBuilder.getViewModel(from: article, readMark: true), index: index)
    }
    
    // MARK: - Private methods
    
    fileprivate func buildListViewModels(articles: [Article], readMarksModel: ReadUrls) -> [ListViewModel] {
        let listViewModels = articles.map {
            self.buildViewModel(article: $0, readMarksModel: readMarksModel)
        }
        return listViewModels
    }
    
    fileprivate func buildViewModel(article: Article, readMarksModel: ReadUrls) -> ListViewModel {
        var readMark = false
        if let resource = article.resource,
           let url = article.url,
           let _ = readMarksModel.firstIndex(resource: resource, value: url)  {
            readMark = true
        }
        return self.listViewModelBuilder.getViewModel(from: article, readMark: readMark)
    }
    
    fileprivate func buildArticlesDictionary(articles: [Article]) {
        var dict = [ String : Article ]()
        articles.forEach({ article in
            if let url = article.url {
                dict[url] = article
            }
        })
        self.articlesDictionary = dict
    }
    
    fileprivate func cleanNotActualReadMarks(settings: SettingsModel, articles: [Article]) {
        let readMarksModel = self.readUrlsService.getReadUrls()
        guard let activeResources = settings.getActiveResources() else { return }
        
        activeResources.forEach { resource in
            guard let readUrls = readMarksModel.urls[resource] else { return }
            let articlesUrls = articles.filter{ $0.resource == resource }.compactMap { $0.url }
            
            let readUrlsSet:Set<String> = Set(readUrls)
  
            let urlsToDeleteFromSaved = readUrlsSet.subtracting(articlesUrls)
            urlsToDeleteFromSaved.forEach { url in
                readUrlsService.removeAsRead(resource: resource, url: url)
            }
        }
    }
}

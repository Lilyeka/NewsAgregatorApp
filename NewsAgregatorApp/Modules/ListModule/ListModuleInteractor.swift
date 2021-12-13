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
    
    var listViewModelBuilder: ListViewModelBuilderProtocol
    var articleService: ArticlesServiceProtocol
    var settingsService: SettingsServiceProtocol
    var readUrlsService: ReadUrlsServiceProtocol
    var userDefaultsService: UserDefaultsManagerProtocol
    
    let notificationCenter = NotificationCenter.default
    
    var articlesDictionary: Dictionary<String, Article>?
    var settingsModel: SettingsModel?
    
    init(listViewModelBuilder: ListViewModelBuilderProtocol,
         articleService: ArticlesServiceProtocol,
         settingsService: SettingsServiceProtocol,
         readUrlsService: ReadUrlsServiceProtocol,
         userDefaultsService: UserDefaultsManagerProtocol) {
        
        self.listViewModelBuilder = listViewModelBuilder
        self.articleService = articleService
        self.settingsService = settingsService
        self.readUrlsService = readUrlsService
        self.userDefaultsService = userDefaultsService
        
        super.init()
        notificationCenter.addObserver(self, selector: #selector(timerNotificationAction(_:)), name: Notification.Name.timerNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: Notification.Name.timerNotification, object: nil)
    }
    
    // MARK - Actions
    @objc func timerNotificationAction(_ notfication: Notification) {
        self.getSettings()
        self.getListModels()
    }
    
    func getSettings() {
        let settingsModel = self.settingsService.getSettingsInfo()
        self.settingsModel = settingsModel
        self.presenter?.settingsRecieved(settingsModel)
    }
    
    func getListModels() {
        guard let settingsModel = self.settingsModel,
              let resources = settingsModel.getActiveResources() else { return }
        
        articleService.getArticles(endpoints: resources) { [weak self] articles, error in
            guard let self = self,
                  let articlesArray = articles?.articles.sorted(by: { $0.publishedAt < $1.publishedAt
                  }) else { return }
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

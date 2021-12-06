//
//  ListInteractorProtocol.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

protocol ListModuleInteractorInput: NSObject {
    func getListModels()
}

protocol ListModuleInteractorOutput: NSObject {
    func listItemsRecieved(_ listItems: [ListViewModel])
}

class ListModuleInteractor: NSObject, ListModuleInteractorInput {
    
    weak var presenter: ListModuleInteractorOutput?
    //TODO - сделать ListModuleInteractorAssembly c функцией create() и в ней инитить интерактор со всеми его зависимостями
    let listViewModelBuilder = ListViewModelBuilder()
    let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager())
    
    //TODO - сделать получение endpoints из модели настроек приложения
    let endpoint1 = EndpointCases.lentaApiEndpoint()
    let endpoint2 = EndpointCases.gazetaApiEndpoint()
    let endpoint3 = EndpointCases.newsApiEndpoint(country: "ru", apiKey: Constants.newsApiOrgKey)
    
    func getListModels() {
        articleService.getArticles(endpoints: [endpoint1, endpoint2, endpoint3]) { [weak self] articles, error in
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

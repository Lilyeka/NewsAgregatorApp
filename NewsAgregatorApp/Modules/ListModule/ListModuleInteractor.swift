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
    let articleService: ArticlesServiceProtocol = ArticlesService(networkManager: NetworkManager(), xmlParser: XMLParserSevice(), jsonParser: JSONDecoder())
    
    var listViewModels: [ListViewModel] = [
        ListViewModel(
            imageUrlString: "",
            title: NSAttributedString(string: "Заголовок новости 1 Заголовок новости 1Заголовок новости 1Заголовок новости 1"),
            subTitle: NSAttributedString(string: "Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1"),
            description: NSAttributedString(string: "Описание новости 1 Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1"),
            hasBeenReadImage: UIImage(named: "read_mark"),
            url: "https://www.google.com/"
        )
    ]
    
    func getListModels() {
        let endpoint1 = EndpointCases.lentaApiEndpoint()
        let endpoint2 = EndpointCases.gazetaApiEndpoint()
        let endpoint3 = EndpointCases.newsApiEndpoint(country: "ru", apiKey: Constants.newsApiOrgKey)

        articleService.getArticles(endpoints: [endpoint1, endpoint2, endpoint3]) { [weak self] articles, error in
            guard let strongSelf = self else { return }

            var listViewModels = articles?.articles.map({ article in
                strongSelf.listViewModelBuilder.getViewModel(from: article)
            })

            strongSelf.listViewModels = listViewModels ?? [ListViewModel]()

            DispatchQueue.main.async {
                strongSelf.presenter?.listItemsRecieved(strongSelf.listViewModels)
            }
        }
    }
}

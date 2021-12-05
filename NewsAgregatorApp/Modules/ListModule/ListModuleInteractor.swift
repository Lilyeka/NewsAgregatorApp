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
    
    let articleService = ArticlesService(networkManager: NetworkManager())
    
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
    
    let parserService = ParserSevice()
    let listViewModelBuilder = ListViewModelBuilder()
    // ------------ XML ----------------
//        func getListModels() {
//            //let url = URL(string: "https://lenta.ru/rss")
//            let url = URL(string: "https://www.gazeta.ru/export/rss/lenta.xml")
//
//            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error ?? "Unknown error")
//                    return
//                }
//
//                self.parserService.parceData(data: data) { [weak self] articles in
//                    guard let strongSelf = self else { return }
//                    strongSelf.listViewModels = articles.map { strongSelf.listViewModelBuilder.getViewModel(from: $0)
//                    }
//                    DispatchQueue.main.async {
//                        strongSelf.presenter?.listItemsRecieved(strongSelf.listViewModels)
//                    }
//                }
//            }
//            task.resume()
//        }
    
    func getListModels() {
        let endpointLenta = EndpointCases.lentaApiEndpoint()
        let endpointGazeta = EndpointCases.gazetaApiEndpoint()
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            self.parserService.parceData(data: data) { [weak self] articles in
                guard let strongSelf = self else { return }
                strongSelf.listViewModels = articles.map { strongSelf.listViewModelBuilder.getViewModel(from: $0)
                }
                DispatchQueue.main.async {
                    strongSelf.presenter?.listItemsRecieved(strongSelf.listViewModels)
                }
            }
        }
        task.resume()
    }
    
    
//    func getListModels() {
//        let endpoint = EndpointCases.newsApiEndpoint(country: "ru", apiKey: Constants.newsApiOrgKey)
//
//        articleService.getArticles(endpoint: endpoint) { [weak self] articles, error in
//            guard let strongSelf = self else { return }
//
//            var listViewModels = articles?.articles.map({ article in
//                strongSelf.listViewModelBuilder.getViewModel(from: article)
//            })
//
//            strongSelf.listViewModels = listViewModels ?? [ListViewModel]()
//
//            DispatchQueue.main.async {
//                strongSelf.presenter?.listItemsRecieved(strongSelf.listViewModels)
//            }
//        }
//    }
}

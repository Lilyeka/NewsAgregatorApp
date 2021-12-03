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

class ListInteractor: NSObject, ListModuleInteractorInput {

    weak var presenter: ListModuleInteractorOutput?
    
    let articleService = ArticlesService(networkManager: NetworkManager())
    
    
    func getListModels() {
        articleService.getArticles(from: "ru") { articles, error in
            print(articles)
        }

        var listViewModels: [ListViewModel] = [
            ListViewModel(
                image: UIImage(named: "default_list_image"),
                title: NSAttributedString(string: "Заголовок новости 1 Заголовок новости 1Заголовок новости 1Заголовок новости 1"),
                subTitle: NSAttributedString(string: "Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1"),
                description: NSAttributedString(string: "Описание новости 1 Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1"),
                hasBeenReadImage: UIImage(named: "read_mark"),
                url: "https://www.google.com/"
            )
        ]
        self.presenter?.listItemsRecieved(listViewModels)
    }
}

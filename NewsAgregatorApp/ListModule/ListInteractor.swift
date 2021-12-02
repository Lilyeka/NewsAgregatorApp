//
//  ListInteractorProtocol.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

protocol ListInteractorProtocol: NSObject {
    func getListModels() -> [ListViewModel]
}

class ListInteractor: NSObject, ListInteractorProtocol {
    
    func getListModels() -> [ListViewModel] {
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
        return listViewModels
    }
}

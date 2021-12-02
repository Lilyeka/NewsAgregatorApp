//
//  ListPresenter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation

protocol ListInputProtocol: NSObject {
    func updateView(with: [ListViewModel])
}

class ListPresenter:  NSObject, ListOutputProtocol {

    private weak var view: ListInputProtocol?
    var router: ListRouterProtocol
    var interactor: ListInteractorProtocol
    
    init(view: ListInputProtocol, interactor: ListInteractorProtocol, router: ListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func listItemDidSelect() {
        self.router.goToListDetailModule()
    }
    
    func viewDidLoad() {
        self.view?.updateView(with: self.interactor.getListModels())
    }
}

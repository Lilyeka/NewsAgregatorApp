//
//  ListPresenter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation

protocol ListModuleViewInput: NSObject {
    func updateView(with: [ListViewModel])
}

class ListModulePresenter:  NSObject, ListModuleViewOutput {
    private weak var view: ListModuleViewInput?
    var router: ListRouterProtocol
    var interactor: ListModuleInteractorInput
    
    init(view: ListModuleViewInput, interactor: ListModuleInteractorInput, router: ListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func listItemDidSelect() {
        self.router.goToListDetailModule()
    }
    
    func viewDidLoad() {
        self.interactor.getListModels()
    }
}

extension ListModulePresenter: ListModuleInteractorOutput {
    func listItemsRecieved(_ listItems: [ListViewModel]) {
        self.view?.updateView(with: listItems)
    }
}

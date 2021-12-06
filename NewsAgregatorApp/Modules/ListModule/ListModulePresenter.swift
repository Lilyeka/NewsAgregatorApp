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

class ListModulePresenter:  NSObject, ListModuleViewOutput, ListModuleInteractorOutput {
    private weak var view: ListModuleViewInput?
    var router: ListRouterProtocol
    var interactor: ListModuleInteractorInput
    
    init(view: ListModuleViewInput, interactor: ListModuleInteractorInput, router: ListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func listItemDidSelect(itemUrl: URL) {
        self.router.openURL(url: itemUrl)
    }
    
    // MARK: -ListModuleViewOutput
    func viewDidLoad() {
        self.interactor.getListModels()
    }
    
    // MARK: - ListModuleInteractorOutput
    func listItemsRecieved(_ listItems: [ListViewModel]) {
        self.view?.updateView(with: listItems)
    }
}




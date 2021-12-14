//
//  ListPresenter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation

protocol ListModuleViewInput: NSObject {
    func updateView(with: [ListViewModel])
    func updateView(with: SettingsModel)
    func updateView(with: ListViewModel, index: Int)
    func updateView(newSettings: SettingsModel)
}

class ListModulePresenter:  NSObject, ListModuleViewOutput, ListModuleInteractorOutput, ListRouterOutput {
    
    private weak var view: ListModuleViewInput?
    var router: ListRouterInput
    var interactor: ListModuleInteractorInput
    
    init(view: ListModuleViewInput, interactor: ListModuleInteractorInput, router: ListRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
        
    // MARK: - ListModuleViewOutput    
    func listItemDidSelect(item: ListViewModel, index: Int) {
        guard let itemUrl = URL(string: item.url) else { return }
        self.router.openURL(url: itemUrl, index: index)
    }
    
    func viewWillAppear() {
        self.interactor.checkSettings()
    }
    
    // MARK: - ListModuleInteractorOutput
    func listItemsRecieved(_ listItems: [ListViewModel]) {
        self.view?.updateView(with: listItems)
    }
    
    func settingsRecieved(_ settings: SettingsModel) {
        self.view?.updateView(with: settings)
    }
    
    func settingsRecieved(newSettings: SettingsModel) {
        self.view?.updateView(newSettings: newSettings)
    }
    
    func listItemsMarkedAsRead(viewModel: ListViewModel, index: Int) {
        self.view?.updateView(with: viewModel, index: index)
    }
    
    // MARK: - ListRouterOutput
    func urlOpened(url: URL, index: Int) {
        self.interactor.markAsRead(url: url, index: index)
    }
}




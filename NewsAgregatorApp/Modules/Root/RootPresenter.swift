//
//  RootPresenterInput.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import Foundation

protocol RootInputProtocol: NSObject {
    
}

class RootPresenter: RootOutputProtocol {
        
    let navigationService: NavigationServiceProtocol
    
    private weak var view: RootInputProtocol?
    
    init(view: RootInputProtocol, navService: NavigationServiceProtocol) {
        self.view = view
        self.navigationService = navService
    }
    
    func viewDidAppear() {
        self.navigationService.goToArticlesList()
    }
    
}

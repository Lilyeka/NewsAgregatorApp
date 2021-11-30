//
//  RootPresenterInput.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import Foundation

protocol RootPresenterInput {
    func viewDidAppear()
}

class RootPresenter: RootPresenterInput {
        
    let navigationService: NavigationServiceProtocol
    
    private weak var view: RootViewController?
    //var router: RootRouter?
    
    init(view: RootViewController, /*router: RootRouter,*/ navService: NavigationServiceProtocol) {
        self.view = view
        self.navigationService = navService
    }
    
    func viewDidAppear() {
        self.navigationService.present(ArticleListViewController(), animated: true)
    }
    
}

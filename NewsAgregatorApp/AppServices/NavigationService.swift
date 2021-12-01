//
//  NavigationService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol NavigationServiceProtocol {
    func goToArticlesList()
}

class NavigationService: NavigationServiceProtocol {
    
    var rootController: UIViewController
    
    init(rootController: UIViewController) {
        self.rootController = rootController
    }
        
    func goToArticlesList() {
        let articlesListVC = ArticleListViewController()
        self.present(articlesListVC, animated: true)
    }
    
    private func present(_ controller: UIViewController, animated: Bool) {
        self.rootController.present(controller, animated: animated)
    }
}

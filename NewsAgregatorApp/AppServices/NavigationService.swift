//
//  NavigationService.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol NavigationServiceProtocol {
    func goToMainTabBar()
}

class NavigationService: NavigationServiceProtocol {
    
    var rootController: UIViewController
    
    init(rootController: UIViewController) {
        self.rootController = rootController
    }
        
    func goToMainTabBar() {
        //TODO - обёртку в навигейшн контроллер перенести в ассембли (а в ассембли использовать фабрику/декоратор)
        let listModule = UINavigationController(rootViewController: ListModuleAssembly.create())
        let settingsModule = UINavigationController(rootViewController: SettingsModuleAssembly.create())
        let tabBarModule = TabBarModuleAssembly.create(subModules: (list: listModule, settings: settingsModule), presentationStyle: .overFullScreen)
        self.present(tabBarModule, animated: true)
    }
    
    private func present(_ controller: UIViewController, animated: Bool) {
        self.rootController.present(controller, animated: animated)
    }
}

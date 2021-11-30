//
//  ServiceContainer.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import Foundation

class ServiceContainer {
    
    static var navigationService: NavigationServiceProtocol {
        _navigationService
    }
    
    private static var _navigationService: NavigationServiceProtocol!
    
    static func buildNavigationService(rootModule: RootViewController) {
        _navigationService = NavigationService(rootController: rootModule)
    }
}

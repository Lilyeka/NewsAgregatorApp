//
//  ListAssembly.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

enum ListModuleAssembly {
    
    static func create() -> ListViewController {
        let view = ListViewController(presentationStyle: .overFullScreen)
        self.injectProperties(in: view)
        return view
    }
    
    private static func injectProperties(in view: ListViewController) {
        let interactor = ListModuleInteractorAssembly.create()
        let router = ListModuleRouter()
        let presenter = ListModulePresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        router.presenter = presenter
    }
}

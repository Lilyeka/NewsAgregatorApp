//
//  TabBarModuleAssembly.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 05.12.2021.
//

import UIKit

enum TabBarModuleAssembly {
    static func create(subModules: TabBarModuleRouter.Submodules, presentationStyle: UIModalPresentationStyle) -> TabBarViewController {
        let tabs = TabBarModuleRouter.tabs(usingSubmodules: subModules)
        let view = TabBarViewController(tabs: tabs)
        view.modalPresentationStyle = presentationStyle
        self.injectProperties(in: view)
        return view
    }
    
    private static func injectProperties(in view: TabBarViewController) {
        
    }
}

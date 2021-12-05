//
//  SwiftTabBarModuleRouter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 05.12.2021.
//

import Foundation
import UIKit

protocol TabBarModuleRouterProtocol {
    
}

class TabBarModuleRouter: TabBarModuleRouterProtocol {
    
    typealias Submodules = (
        list: UIViewController,
        settings: UIViewController
    )

    weak var viewController: ListViewController?

}

extension TabBarModuleRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> Tabs {
        let listTabBarItem = UITabBarItem(title: "News", image: nil, tag: 10)
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 11)
        submodules.list.tabBarItem = listTabBarItem
        submodules.settings.tabBarItem = settingsTabBarItem
        
        return (
            list: submodules.list,
            settings: submodules.settings
        )
    }
}

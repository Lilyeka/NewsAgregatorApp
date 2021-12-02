//
//  ListRouter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation
import UIKit

protocol ListRouterProtocol {
    func goToListDetailModule()
}

class ListRouter: ListRouterProtocol {
    weak var viewController: ListViewController?

    func goToListDetailModule() {
        self.viewController?.navigationController?.pushViewController(WebViewViewController(), animated: true)
    }
}

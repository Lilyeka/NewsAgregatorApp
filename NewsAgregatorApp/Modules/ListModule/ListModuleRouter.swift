//
//  ListRouter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation
import UIKit
import SafariServices

protocol ListRouterInput: AnyObject {
    func openURL(url: URL, index: Int)
}

protocol ListRouterOutput: AnyObject {
    func urlOpened(url: URL, index: Int)
}

class ListModuleRouter: ListRouterInput {
    weak var viewController: ListViewController?
    weak var presenter: ListRouterOutput?

    func openURL(url: URL, index: Int) {
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.viewController?.present(vc, animated: true) {
            self.presenter?.urlOpened(url: url, index: index)
        }
    }
}


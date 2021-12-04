//
//  ListRouter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import Foundation
import UIKit
import SafariServices

protocol ListRouterProtocol {
    func openURL(url: URL)
}

class ListModuleRouter: ListRouterProtocol {
    weak var viewController: ListViewController?

    func openURL(url: URL) {
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.viewController?.present(vc, animated: true)
    }
}


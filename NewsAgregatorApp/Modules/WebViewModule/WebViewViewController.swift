//
//  WebViewViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit
import SafariServices

class WebViewViewController: UIViewController, SFSafariViewControllerDelegate {
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        if let url = url {
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}


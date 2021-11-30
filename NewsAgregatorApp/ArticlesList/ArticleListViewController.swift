//
//  ArticleListViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

//
//  RootViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

class RootViewController: UIViewController {

    var presenter: RootPresenterInput!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ServiceContainer.buildNavigationService(rootModule: self)
        self.presenter = RootPresenter(view: self, navService: ServiceContainer.navigationService)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }
    
    
}


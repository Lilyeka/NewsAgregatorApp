//
//  RootViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol RootOutputProtocol {
    func viewDidAppear()
}

class RootViewController: UIViewController, RootInputProtocol {

    var presenter: RootOutputProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        NavigationServiceContainer.buildNavigationService(rootModule: self)
        self.presenter = RootPresenter(view: self, navService: NavigationServiceContainer.navigationService)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }
}


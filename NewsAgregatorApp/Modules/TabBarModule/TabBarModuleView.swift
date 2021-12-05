//
//  TabBarViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 05.12.2021.
//

import UIKit

typealias Tabs = (
    list: UIViewController,
    settings: UIViewController
)

class TabBarViewController: UITabBarController {
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [tabs.list, tabs.settings]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//
//  SettingsModuleAssembly.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 05.12.2021.
//

import UIKit

enum SettingsModuleAssembly {
    static func create() -> SettingsViewController {
        let view = SettingsViewController()
        self.injectProperties(in: view)
        return view
    }
    
    private static func injectProperties(in view: SettingsViewController) {
        
    }
}

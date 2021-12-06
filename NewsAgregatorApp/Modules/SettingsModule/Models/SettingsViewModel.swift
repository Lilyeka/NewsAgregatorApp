//
//  SettingsViewModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

struct SettingsViewModel {
    var resources: [ResourceViewModel]
    var mode: ShowModes
}

struct ResourceViewModel {
    var title: NSAttributedString
    var active: Bool
}

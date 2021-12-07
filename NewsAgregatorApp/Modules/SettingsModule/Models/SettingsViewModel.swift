//
//  SettingsViewModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

struct SettingsViewModel {
    enum Sections: String {
        case resoursesSection
        case modeSection
    }
    var resources: [ResourceViewModel]
    var mode: ShowModes
    var sections: [Sections] = [.resoursesSection, .modeSection]
}

struct ResourceViewModel {
    var title: NSAttributedString
    var active: Bool
}

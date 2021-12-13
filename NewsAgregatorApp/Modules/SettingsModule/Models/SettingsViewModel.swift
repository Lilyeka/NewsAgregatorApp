//
//  SettingsViewModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

struct SettingsViewModel {
    enum Sections: String {
        case resoursesSection = "Источники новостей"
        case modeSection = "Режим отображения"
        case updIntervalSection = "Приодичность обновления: (сек.)"
    }
    var resources: [ResourceViewModel]
    var mode: ShowModes
    var timeInterval: Int
    var sections: [Sections] = [.resoursesSection, .modeSection, .updIntervalSection]
}

struct ResourceViewModel {
    var title: NSAttributedString
    var active: Bool
}

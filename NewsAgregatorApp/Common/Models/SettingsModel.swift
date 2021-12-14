//
//  SettingsModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

class SettingsModel: Codable {
    var mode: ShowModes
    var resourses: [ShowResources]
    var updatingInterval: Int
    
    init(mode: ShowModes, resourses: [ShowResources], updatingInterval: Int) {
        self.mode = mode
        self.resourses = resourses
        self.updatingInterval = updatingInterval
    }
        
    func getActiveResources() -> [Resources]? {
        return self.resourses.filter{ $0.isActive }.map{ $0.resource }
    }
    
    func changeActiveStateForResource(index:Int, isActive: Bool) {
        if index < self.resourses.count {
            self.resourses[index].isActive = isActive
        }
    }
    
    func changeShowMode(modeIndex: Int) {
        if modeIndex < ShowModes.allCases.count {
            let mode = ShowModes.allCases[modeIndex]
            self.mode = mode
        }
    }
}

struct ShowResources: Codable {
    var resource: Resources
    var isActive: Bool
}

enum ShowModes: String, CaseIterable, Codable {
    case normalMode = "Обычный"
    case extentMode = "Расширенный"
    
    func isExtendedMode() -> Bool {
        return self == .extentMode ? true : false
    }
}

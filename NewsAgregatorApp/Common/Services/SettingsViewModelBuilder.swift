//
//  SettingsViewModelBuilder.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

protocol SettingsViewModelBuilderProtocol {
    func getSettingsViewModel(settings: SettingsModel) -> SettingsViewModel 
}

struct SettingsViewModelBuilder: SettingsViewModelBuilderProtocol {
    
    func getSettingsViewModel(settings: SettingsModel) -> SettingsViewModel {

        let resViewModels: [ResourceViewModel] = settings.resourses.map { resource, isActive in
            let attributedTitleString = self.getAttributedString(string: resource.rawValue, fontSize: 20, color: .black, aligment: .left)
            return ResourceViewModel(title: attributedTitleString, active: isActive)
        }
        
        let viewModel = SettingsViewModel(resources: resViewModels, mode: settings.mode, sections: [.resoursesSection, .modeSection])
        return viewModel
    }
    
    private func getAttributedString(string: String, fontSize: CGFloat, color: UIColor, aligment: NSTextAlignment) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        paragraphStyle.firstLineHeadIndent = 5.0

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: string, attributes: attributes)
    }
}

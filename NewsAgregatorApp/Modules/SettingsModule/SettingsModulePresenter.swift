//
//  SettingsModulePresenter.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import Foundation

protocol SettingsModuleViewInput: AnyObject {
    func updateView(with settings: SettingsViewModel)
}

class SettingsModulePresenter: SettingsModuleViewOutput, SettingsModuleInteractorOutput {
    
    weak var view: SettingsModuleViewInput?
    var interactor: SettingsModuleInteractorInput?
    
    init(view: SettingsModuleViewInput, interactor: SettingsModuleInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
    //MARK: -SettingsModuleViewOutput
    func viewDidLoad() {
        self.interactor?.getSettings()
    }
    
    //MARK: -SettingsModuleInteractorOutput
    func settingsRecieved(settings: SettingsViewModel) {
        self.view?.updateView(with: settings)
    }
}

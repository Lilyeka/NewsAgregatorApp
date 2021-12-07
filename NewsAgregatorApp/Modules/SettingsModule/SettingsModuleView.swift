//
//  WebViewViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 02.12.2021.
//

import UIKit

protocol SettingsModuleViewOutput {
    func viewDidLoad()
}

class SettingsViewController: UIViewController, SettingsModuleViewInput {
  
    var presenter: SettingsModuleViewOutput?
    var viewModel: SettingsViewModel?
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupUI()
        self.setupLayout()
        self.presenter?.viewDidLoad()
    }
    
    fileprivate func setupUI() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.reuseIdentifier)
        self.tableView.register(SegmentControlTableViewCell.self, forCellReuseIdentifier: SegmentControlTableViewCell.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60.0
        self.view.addSubview(tableView)
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - SettingsModuleViewInput
    func updateView(with settings: SettingsViewModel) {
        self.viewModel = settings
        self.tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionItem = viewModel?.sections[section] else { return 0 }
        switch sectionItem {
        case .modeSection:
            return 1
        case .resoursesSection:
            return viewModel?.resources.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = self.viewModel?.resources[indexPath.row]
        
        // TODO - передавать в ячейку вьюмодель ячейки из вьюмодели настроек
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier, for: indexPath) as? SwitchTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel
        return cell
        //        if let dequeCell = tableView.dequeueReusableCell(withIdentifier: SegmentControlTableViewCell.reuseIdentifier, for: indexPath) as? SegmentControlTableViewCell {
        //            cell = dequeCell
        //        }
        
        // let viewModel = listViewModels?[indexPath.row]
        // cell.isExtendedMode = settingsModel
        // cell.viewModel = viewModel
        
    }
}


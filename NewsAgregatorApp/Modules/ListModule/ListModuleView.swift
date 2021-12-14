//
//  ArticleListViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol ListModuleViewOutput: NSObject {
   
    func listItemDidSelect(item: ListViewModel, index: Int)
    func viewWillAppear()
}

class ListViewController: UIViewController {
    
    var presenter: ListModuleViewOutput?
    
    fileprivate var tableView: UITableView!
    fileprivate var activityIndicator: UIActivityIndicatorView!
    
    var listViewModels: [ListViewModel]?
    var settingsModel: SettingsModel?
  
    // MARK: - Lifecycle
    init(presentationStyle: UIModalPresentationStyle) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = presentationStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupUI()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
        
    // MARK: - Private methods
    fileprivate func setupUI() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60.0
        self.view.addSubview(self.tableView)
        
        self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.center = view.center
        self.view.addSubview(self.activityIndicator)
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let viewModel = self.listViewModels?[indexPath.row]
        if let settingsModel = settingsModel {
            cell.isExtendedMode = settingsModel.mode.isExtendedMode()
        }
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let viewModel = listViewModels?[indexPath.row] else { return }
        self.presenter?.listItemDidSelect(item: viewModel, index: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listViewModels?.count ?? 0
    }
}

// MARK: - ListModuleViewInput
extension ListViewController: ListModuleViewInput {
    
    func updateView(newSettings: SettingsModel) {
        self.settingsModel = newSettings
    }
    
    func updateView(with: SettingsModel) {
        self.settingsModel = with
        self.tableView.reloadData()
    }
    
    func updateView(with: [ListViewModel]) {
        self.activityIndicator.stopAnimating()
        self.listViewModels = with
        self.tableView.reloadData()
    }
    
    func updateView(with: ListViewModel, index: Int) {
        self.listViewModels?[index] = with
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

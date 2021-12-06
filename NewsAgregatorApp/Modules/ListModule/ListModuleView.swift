//
//  ArticleListViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol ListModuleViewOutput: NSObject {
    func viewDidLoad()
    func listItemDidSelect(itemUrl: URL)
}

class ListViewController: UIViewController {

    var presenter: ListModuleViewOutput?
    
    fileprivate var tableView: UITableView!
    
    var listViewModels: [ListViewModel]?    
    var settingsModel = true
    
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
        self.presenter?.viewDidLoad()
    }
    
    fileprivate func setupUI() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
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
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let viewModel = listViewModels?[indexPath.row]
        cell.isExtendedMode = settingsModel
        cell.viewModel = viewModel
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let viewModel = listViewModels?[indexPath.row],
              let url = URL(string: viewModel.url) else { return }
        self.presenter?.listItemDidSelect(itemUrl: url)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModels?.count ?? 0
    }
}

extension ListViewController: ListModuleViewInput {
    func updateView(with: [ListViewModel]) {
        self.listViewModels = with
        tableView.reloadData()
    }
}

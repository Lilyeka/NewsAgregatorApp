//
//  ArticleListViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

protocol ListOutputProtocol: NSObject {
    func viewDidLoad()
    func listItemDidSelect()
}

class ListViewController: UIViewController {

    var presenter: ListOutputProtocol?
    
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
    
    func setupUI() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60.0
        self.view.addSubview(tableView)
    }
    
    func setupLayout() {
        
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
        self.presenter?.listItemDidSelect()
    }
    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModels?.count ?? 0
    }
}

extension ListViewController: ListInputProtocol {
    func updateView(with: [ListViewModel]) {
        self.listViewModels = with
    }
}

//
//  ArticleListViewController.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 30.11.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    
    var listViewModels: [ListViewModel] = [
        ListViewModel(
            image: UIImage(named: "default_list_image"),
            title: NSAttributedString(string: "Заголовок новости 1 Заголовок новости 1Заголовок новости 1Заголовок новости 1"),
            subTitle: NSAttributedString(string: "Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1Источник новости 1"),
            description: NSAttributedString(string: "Описание новости 1 Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1Описание новости 1"),
            hasBeenReadImage: UIImage(named: "read_mark")
        )
    ]
    
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
        
         let viewModel = listViewModels[indexPath.row]
        cell.isExtendedMode = settingsModel //
        cell.viewModel = viewModel
      
       // cell.dataModel = dataModel
       // cell.isFavorite = presenter.listViewItemWillShowFavoriteStatus(id: dataModel.id!, itemType: dataModel.type!)
       // cell.delegate = self
        return cell
    }
    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModels.count
    }
}

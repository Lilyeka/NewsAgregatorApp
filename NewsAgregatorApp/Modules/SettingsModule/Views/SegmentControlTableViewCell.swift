//
//  SegmentControlTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

class SegmentControlTableViewCell: UITableViewCell {
    
    var onSegmentChanged:((Int) -> Void)?
    
    var viewModel: ShowModes? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            var i = 0
            ShowModes.allCases.forEach { mode in
                self.segmentControl.insertSegment(withTitle: mode.rawValue, at: i, animated: false)
                i += 1
            }
            if let selectedSegmentIndex = ShowModes.allCases.firstIndex(of: viewModel) {
                self.segmentControl.selectedSegmentIndex = selectedSegmentIndex
            }
        }
    }
    
    var segmentControl: UISegmentedControl =  {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = UIColor.gray
        control.tintColor = UIColor.yellow
        control.backgroundColor = UIColor.white
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(segmentControl)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        self.onSegmentChanged?(selectedIndex)
    }
    
    // MARK: - Private methods
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            self.segmentControl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.segmentControl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.segmentControl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            self.segmentControl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
}

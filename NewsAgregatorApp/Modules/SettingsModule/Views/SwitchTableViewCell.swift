//
//  SwitchTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    var onSwitchChanged:((Bool) -> Void)?

    var viewModel: ResourceViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            self.titleLabel.attributedText = viewModel.title
            self.switchControl.isOn = viewModel.active
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let switchControl: UISwitch =  {
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        return switchControl
    }()
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryView = switchControl
        self.contentView.addSubview(titleLabel)
        self.setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func switchChanged(sender: UISwitch) {
        self.onSwitchChanged?(sender.isOn)
    }
    
    // MARK: - Private methods
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
}

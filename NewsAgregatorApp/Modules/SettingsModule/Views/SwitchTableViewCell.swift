//
//  SwitchTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
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
       return UISwitch()
    }()
    
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryView = switchControl
        self.contentView.addSubview(titleLabel)
        self.setupLayout()
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

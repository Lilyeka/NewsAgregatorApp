//
//  SegmentControlTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 06.12.2021.
//

import UIKit

class SegmentControlTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = " Заголовок для сегмент контрола"
        return label
    }()
    
    let segmentControl: UISegmentedControl =  {
        let control = UISegmentedControl(items: ["One", "Two", "Three"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = UIColor.gray
        control.tintColor = UIColor.yellow
        control.backgroundColor = UIColor.white
        return control
    }()
        
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(segmentControl)
        self.setupLayout()
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            
            self.segmentControl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.segmentControl.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8.0),
            self.segmentControl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            self.segmentControl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
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

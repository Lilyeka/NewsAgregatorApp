//
//  ArticleTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 01.12.2021.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    var viewModel: ListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            if let imgUrl = URL(string: viewModel.imageUrlString) {
                self.listImageView.kf.setImage(with: imgUrl)
            }
            self.titleLabel.attributedText = viewModel.title
            self.subTitleLabel.attributedText = viewModel.subTitle
            self.descriptionLabel.attributedText = viewModel.description
            self.markImageView.image = viewModel.hasBeenReadImage
            self.markImageView.isHidden = !viewModel.hasBeenRead
        }
    }
    var isExtendedMode: Bool = true
    
    var listImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.backgroundColor = .green
        return label
    }()
    
    var subTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.backgroundColor = .gray
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    var markImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        
        self.containerView.addSubview(listImageView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(markImageView)
        
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(subTitleLabel)
      
        NSLayoutConstraint.activate([
            self.markImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8.0),
            self.markImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8.0),
            self.markImageView.heightAnchor.constraint(equalToConstant: 26.0),
            self.markImageView.widthAnchor.constraint(equalToConstant: 26.0),
            
            self.listImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8.0),
            self.listImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8.0),
            self.listImageView.heightAnchor.constraint(equalToConstant: 90.0),
            self.listImageView.widthAnchor.constraint(equalToConstant: 100.0),
            self.listImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.containerView.bottomAnchor, constant: -8.0),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.listImageView.trailingAnchor, constant: 8.0),
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.markImageView.leadingAnchor, constant: -8.0),
            self.titleLabel.bottomAnchor.constraint(lessThanOrEqualTo:
                self.containerView.bottomAnchor, constant: -8.0),
            
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
        
            self.subTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 100.0),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 4.0),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            self.subTitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
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

    }

}


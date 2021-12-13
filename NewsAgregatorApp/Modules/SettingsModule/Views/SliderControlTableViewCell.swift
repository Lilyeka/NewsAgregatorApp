//
//  PickerControlTableViewCell.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 13.12.2021.
//

import UIKit

class SliderControlTableViewCell: UITableViewCell {
    
    var model = 10
    var onSliderChanged:((Int) -> Void)?
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 5
        slider.maximumValue = 600
        slider.isContinuous = false
        slider.tintColor = .systemGreen
        return slider
    }()
    
    let sliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.backgroundColor = .gray
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        self.slider.value = Float(self.model)
        self.sliderLabel.text = String(self.model)
        self.contentView.addSubview(slider)
        self.contentView.addSubview(sliderLabel)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func sliderValueDidChange(_ sender: UISlider) {
        let step: Float = 5.0
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        self.sliderLabel.text = String(Int(roundedStepValue))
        self.onSliderChanged?(Int(roundedStepValue))
    }
    
    // MARK: - Private methods
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            self.slider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.slider.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.slider.widthAnchor.constraint(equalToConstant: 280),
            self.slider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0),
            
            self.sliderLabel.leadingAnchor.constraint(equalTo: self.slider.trailingAnchor, constant: 8.0),
            self.sliderLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.sliderLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            self.sliderLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
}



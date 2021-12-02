//
//  UITableViewCell+Extension.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 01.12.2021.
//

import UIKit

extension UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

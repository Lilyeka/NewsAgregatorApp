//
//  String+Extension.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 12.12.2021.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        let dateObj = dateFormatter.date(from: self)
        return dateObj
    }
}

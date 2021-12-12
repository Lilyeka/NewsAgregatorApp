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
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        let dateObj = dateFormatter.date(from: self)
        return dateObj
    }
}

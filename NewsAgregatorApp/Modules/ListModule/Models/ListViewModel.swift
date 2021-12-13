//
//  ListViewModel.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 01.12.2021.
//

import Foundation
import UIKit

struct ListViewModel {
    var imageUrlString: String
    var title: NSAttributedString
    var subTitle: NSAttributedString
    var description: NSAttributedString
    var hasBeenReadImage: UIImage? = UIImage(named: "read_mark")
    var readMark: Bool
    var url: String
}

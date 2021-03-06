//
//  ListViewModelBuilder.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 03.12.2021.
//

import UIKit

protocol ListViewModelBuilderProtocol {
    func getViewModel(from model: Article, readMark: Bool) -> ListViewModel
}

struct ListViewModelBuilder: ListViewModelBuilderProtocol  {
    
    func getViewModel(from model: Article, readMark: Bool) -> ListViewModel {
  
        let attributedTitleString = self.getAttributedString(string: model.title, fontSize: 20, color: .black, aligment: .left)
        let attributedSubTitleString = self.getAttributedString(string: (model.resource?.rawValue ?? "") + " [" + model.publishedAt.ISO8601Format() + "]", fontSize: 14, color: .red, aligment: .right)
        let attributedDescriptionString = self.getAttributedString(string: model.description ?? "", fontSize: 16, color: .black, aligment: .left)
    
        return ListViewModel(imageUrlString: model.urlToImage ?? "", title: attributedTitleString, subTitle: attributedSubTitleString, description: attributedDescriptionString, readMark: readMark, url: model.url ?? "", publishedAt: model.publishedAt)
        
    }
    
    private func getAttributedString(string: String, fontSize: CGFloat, color: UIColor, aligment: NSTextAlignment) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        paragraphStyle.firstLineHeadIndent = 5.0

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: string, attributes: attributes)
    }
    
}

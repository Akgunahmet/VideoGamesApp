//
//  CGFloat+Extension.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

extension CGFloat {
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
}
extension String {
    func stripHTMLTags() -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
    }
}


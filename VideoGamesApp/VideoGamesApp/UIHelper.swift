//
//  UIHelper.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize  = CGSize(width: CGFloat.deviceWidth, height: CGFloat.deviceWidth / 4.4)
        layout.minimumLineSpacing = 2
        return layout
    }
}


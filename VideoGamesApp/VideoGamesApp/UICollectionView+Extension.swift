//
//  UICollectionView+Extension.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}


//
//  CustomPageController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

class CustomPageControl: UIPageControl {
    override var currentPage: Int {
        didSet {
            updatePageIndicatorTintColor()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePageIndicatorTintColor()
    }
    
    private func updatePageIndicatorTintColor() {
        for (index, dotView) in subviews.enumerated() {
            dotView.layer.cornerRadius = dotView.frame.size.height / 2
            dotView.clipsToBounds = true
            dotView.backgroundColor = (index == currentPage) ? .black : .gray
        }
    }
}

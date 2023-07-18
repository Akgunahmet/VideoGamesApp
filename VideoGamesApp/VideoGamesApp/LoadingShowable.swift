//
//  LoadingShowable.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 18.07.2023.
//


import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}


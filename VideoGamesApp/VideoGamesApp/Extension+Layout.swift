//
//  CoreData+Helpers.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//


import UIKit

extension HomeViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pageView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),

            collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension UIView {
    func pinToEdgesOf(view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


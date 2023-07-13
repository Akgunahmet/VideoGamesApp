//
//  FavoritesViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

}
extension FavoritesViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
    
        return cell
    }
}

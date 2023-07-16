//
//  FavoritesViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject {
    
    func style()
    func layout()
    func reloadCollectionView()
    func navigateToDetailScreen(games: Games)
}
class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    
    private var collectionView: UICollectionView!
    private let viewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
            }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteGames()
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarViewController
        mainTabController.viewControllers?[1].tabBarItem.badgeValue = nil
    }

}
extension FavoritesViewController {
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    func navigateToDetailScreen(games: Games) {
        DispatchQueue.main.async {
            let detailScreen = DetailsViewController(games: games)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    @objc private func deleteAllButtonTapped() {
        viewModel.deleteAllFavoriteGames()
    }
    
     func style() {
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
         let deleteAllButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteAllButtonTapped))
             deleteAllButton.tintColor = .red
             navigationItem.rightBarButtonItem = deleteAllButton
    }
     func layout() {
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
        return viewModel.resultCoreDataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.configure(gamesCoreData: viewModel.resultCoreDataItems[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: Int(viewModel.resultCoreDataItems[indexPath.item].id))
    }
    
}

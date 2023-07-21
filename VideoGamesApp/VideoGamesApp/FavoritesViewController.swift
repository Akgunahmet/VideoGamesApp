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
    
    var noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Favori Bulunamadı"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteGames()
        viewModel.badgeValue()
    }
}

extension FavoritesViewController {
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
        if viewModel.resultCoreDataItems.isEmpty {
            collectionView.isHidden = true
            noResultsLabel.isHidden = false
        } else {
            collectionView.isHidden = false
            noResultsLabel.isHidden = true
        }
    }
    
    func navigateToDetailScreen(games: Games) {
        DispatchQueue.main.async {
            let detailScreen = DetailsViewController(games: games)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    
    @objc private func deleteAllButtonTapped() {
        showConfirmationAlert()
    }
    
    private func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Delete All Favorites", message: "Are you sure you want to delete all favorite games?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel.deleteAllFavoriteGames()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func style() {
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        view.addSubview(noResultsLabel)
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
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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

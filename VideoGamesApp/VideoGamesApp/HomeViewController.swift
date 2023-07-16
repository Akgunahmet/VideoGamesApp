//
//  HomeViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//
//

//import UIKit
//
//protocol HomeViewControllerProtocol: AnyObject {
//    func style()
//    func layout()
//    func reloadCollectionView()
//    func navigateToDetailScreen(games: Games)
//    func setupPageViewControllerIfNeeded()
//}
//
//final class HomeViewController: UIViewController, HomeViewControllerProtocol {
//
//    private var pageView: UIPageViewController!
//    private var collectionView: UICollectionView!
//    private let viewModel = HomeViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.view = self
//        viewModel.viewDidLoad()
//
//    }
//    private var noResultsLabel: UILabel = {
//        let label = UILabel()
//
//        label.text = "Sonuç Bulunamadı"
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        label.textColor = .gray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isHidden = true
//        return label
//    }()
//
//
//    private func setupPageViewController() {
//        pageView.dataSource = self
//
//        let initialViewControllers = viewModel.games.prefix(3).enumerated().map { (index, game) in
//            return createViewController(withImageURL: game.backgroundImage ?? "", index: index)
//        }
//
//        if let initialViewController = initialViewControllers.first {
//            pageView.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
//        }
//        pageView.dataSource = (initialViewControllers.count > 1) ? self : nil
//    }
//
//    private func createViewController(withImageURL imageURL: String, index: Int) -> UIViewController {
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = .clear
//
//        let imageView = UIImageView(frame: viewController.view.bounds)
//     //   imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        if let url = URL(string: imageURL) {
//            URLSession.shared.dataTask(with: url) { [weak imageView] (data, response, error) in
//                guard let data = data, let image = UIImage(data: data) else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    imageView?.image = image
//                }
//            }.resume()
//        }
//       // imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        imageView.translatesAutoresizingMaskIntoConstraints = false // Add this line to prevent layout issues
//        viewController.view.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
//        ])
//        viewController.view.tag = index
//        return viewController
//    }
//
//}
//// MARK: - Extension Helper Function
//extension HomeViewController {
//
//    func reloadCollectionView() {
//        collectionView.reloadOnMainThread()
//        if viewModel.filteredGames.isEmpty {
//              collectionView.isHidden = true
//              noResultsLabel.isHidden = false
//          } else {
//              collectionView.isHidden = false
//              noResultsLabel.isHidden = true
//          }
//    }
//
//    func navigateToDetailScreen(games: Games) {
//        DispatchQueue.main.async {
//            let detailScreen = DetailsViewController(games: games)
//            self.navigationController?.pushViewController(detailScreen, animated: true)
//        }
//    }
//    func setupPageViewControllerIfNeeded() {
//        DispatchQueue.main.async { [weak self] in
//            self?.setupPageViewController()
//        }
//    }
//    func style() {
//
//        view.backgroundColor = .systemBackground
//        let searchController = UISearchController(searchResultsController: nil)
//        self.navigationItem.searchController = searchController
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.searchBar.delegate = self
//        searchController.hidesNavigationBarDuringPresentation = false // title gizlenmesini engellemek için
//        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
//        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
//        pageControl.pageIndicatorTintColor = .gray
//        pageControl.currentPageIndicatorTintColor = .black
//
//    }
//    func layout() {
//
//        addChild(pageView)
//        view.addSubview(pageView.view)
//        pageView.didMove(toParent: self)
//        pageView.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(noResultsLabel)
//
//        NSLayoutConstraint.activate([
//
//
//            pageView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pageView.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
//
//            //collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor),
//            collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor, constant: pageView.view.isHidden ? 0 : 8),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
//
//// MARK: - UIPageViewControllerDataSource
//
//extension HomeViewController: UIPageViewControllerDataSource{
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let currentIndex = viewController.view.tag
//        guard currentIndex > 0 else {
//            return nil
//        }
//
//        let previousIndex = currentIndex - 1
//        return createViewController(withImageURL: viewModel.games[previousIndex].backgroundImage ?? "", index: previousIndex)
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let currentIndex = viewController.view.tag
//        guard currentIndex < 2 else {
//            return nil
//        }
//        let nextIndex = currentIndex + 1
//        return createViewController(withImageURL: viewModel.games[nextIndex].backgroundImage ?? "", index: nextIndex)
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return pageViewController.viewControllers?.first?.view.tag ?? 0
//    }
//}
//
//// MARK: - UICollectionViewDelegate - UICollectionViewDataSource
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return viewModel.filteredGames.isEmpty ? viewModel.games.count: viewModel.filteredGames.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath) as! GameCell
//        let game = viewModel.filteredGames.isEmpty ? viewModel.games[indexPath.item] : viewModel.filteredGames[indexPath.item]
//        cell.configure(games: game)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.getDetail(id: viewModel.filteredGames.isEmpty ? viewModel.games[indexPath.item]._id : viewModel.filteredGames[indexPath.item]._id)
//    }
//}
//// MARK: - UISearchBarDelegate
////
////extension HomeViewController: UISearchBarDelegate {
////
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        if searchText.isEmpty {
////            // Show the page view controller
////            pageView.view.isHidden = false
////            collectionView.isHidden = true
////            // Reload the collection view with empty data
////            self.viewModel.games = []
////            viewModel.view?.style()
////            viewModel.view?.layout()
////            viewModel.getGames()
////           // viewModel.viewDidLoad()
////
////        } else if searchText.count >= 3 {
////
////
////            pageView.view.isHidden = true
////            collectionView.isHidden = false
////
////            self.viewModel.service.downloadSearchGames(searchTerm: searchText) { result in
////                self.collectionView.reloadOnMainThread()
////                self.viewModel.games = result ?? []
////
////            }
////            // Adjust the constraints to make the collection view occupy the entire screen
////            NSLayoutConstraint.activate([
////                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
////                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            ])
////        } else {
////            return
////        }
////
////        // Reload the collection view
////        collectionView.reloadOnMainThread()
////        // Update the layout
////        view.layoutIfNeeded()
////
////    }
////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////
////        pageView.view.isHidden = false
////        collectionView.isHidden = true
////        // Reload the collection view with empty data
////        self.viewModel.games = []
////        viewModel.view?.style()
////        viewModel.view?.layout()
////        viewModel.getGames()
////
////        }
////
////    }
////
//extension HomeViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard searchText.count >= 3 || searchText.isEmpty else {
//            return
//        }
//
//        if searchText.isEmpty {
//            searchBar.resignFirstResponder()
//
//            viewModel.filteredGames = Array(viewModel.games.dropFirst(3))
//
//            // Show the page controller and adjust collection view constraints
//            pageView.view.isHidden = false
//
//            // Remove the collection view and page view from their superviews
//            collectionView.removeFromSuperview()
//            pageView.view.removeFromSuperview()
//
//            // Re-add the collection view and page view with updated constraints
//            view.addSubview(collectionView)
//            view.addSubview(pageView.view)
//
//            layout() // Reapply the layout to update the constraints
//        } else {
//            viewModel.filteredGames = viewModel.games.filter { game in
//                if let gameTitle = game.name {
//                    return gameTitle.lowercased().contains(searchText.lowercased())
//                }
//                return false
//            }
//
//            // Hide the page controller and adjust collection view constraints
//            pageView.view.isHidden = true
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        }
//
//        reloadCollectionView()
//
//    }
//}


import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func style()
    func layout()
    func reloadCollectionView()
    func navigateToDetailScreen(games: Games)
    func setupPageViewControllerIfNeeded()
}

final class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    private var pageView: UIPageViewController!
    private var collectionView: UICollectionView!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    private var noResultsLabel: UILabel = {
        let label = UILabel()

        label.text = "Sonuç Bulunamadı"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private func setupPageViewController() {
        pageView.dataSource = self
        
        let initialViewControllers = viewModel.games.prefix(3).enumerated().map { (index, game) in
            return createViewController(withImageURL: game.backgroundImage ?? "", index: index)
        }
        
        if let initialViewController = initialViewControllers.first {
            pageView.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
        pageView.dataSource = (initialViewControllers.count > 1) ? self : nil
    }
    
    private func createViewController(withImageURL imageURL: String, index: Int) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        
        let imageView = UIImageView(frame: viewController.view.bounds)
     //   imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { [weak imageView] (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    imageView?.image = image
                }
            }.resume()
        }
       // imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.translatesAutoresizingMaskIntoConstraints = false // Add this line to prevent layout issues
        viewController.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
        ])
        viewController.view.tag = index
        return viewController
    }
    
}
// MARK: - Extension Helper Function
extension HomeViewController {
    

    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadOnMainThread()
            if self?.viewModel.filteredGames.isEmpty ?? true {
                self?.collectionView.isHidden = true
                self?.noResultsLabel.isHidden = false
            } else {
                self?.collectionView.isHidden = false
                self?.noResultsLabel.isHidden = true
            }
        }
    }

    
    func navigateToDetailScreen(games: Games) {
        DispatchQueue.main.async {
            let detailScreen = DetailsViewController(games: games)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    func setupPageViewControllerIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.setupPageViewController()
        }
    }
    func style() {
        
        view.backgroundColor = .systemBackground
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false // title gizlenmesini engellemek için
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        
    }
    func layout() {
        
        addChild(pageView)
        view.addSubview(pageView.view)
        pageView.didMove(toParent: self)
        pageView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noResultsLabel)
        NSLayoutConstraint.activate([
            
            
            pageView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            //collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor, constant: pageView.view.isHidden ? 0 : 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource

extension HomeViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewController.view.tag
        guard currentIndex > 0 else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        return createViewController(withImageURL: viewModel.games[previousIndex].backgroundImage ?? "", index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewController.view.tag
        guard currentIndex < 2 else {
            return nil
        }
        let nextIndex = currentIndex + 1
        return createViewController(withImageURL: viewModel.games[nextIndex].backgroundImage ?? "", index: nextIndex)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageViewController.viewControllers?.first?.view.tag ?? 0
    }
}

// MARK: - UICollectionViewDelegate - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //centerLabel.isHidden = self.viewModel.games.count != 0
        return viewModel.filteredGames.isEmpty ? viewModel.games.count: viewModel.filteredGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath) as! GameCell
        let game = viewModel.filteredGames.isEmpty ? viewModel.games[indexPath.item] : viewModel.filteredGames[indexPath.item]
        cell.configure(games: game)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.filteredGames.isEmpty ? viewModel.games[indexPath.item]._id : viewModel.filteredGames[indexPath.item]._id)
    }
}
// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count >= 3 || searchText.isEmpty else {
            return
        }

        if searchText.isEmpty {
            searchBar.resignFirstResponder()

            viewModel.filteredGames = Array(viewModel.games.dropFirst(3))

            // Show the page controller and adjust collection view constraints
            pageView.view.isHidden = false

            // Remove the collection view and page view from their superviews
            collectionView.removeFromSuperview()
            pageView.view.removeFromSuperview()

            // Re-add the collection view and page view with updated constraints
            view.addSubview(collectionView)
            view.addSubview(pageView.view)

            layout() // Reapply the layout to update the constraints
        } else {
            viewModel.filteredGames = viewModel.games.filter { game in
                if let gameTitle = game.name {
                    return gameTitle.lowercased().contains(searchText.lowercased())
                }
                return false
            }

            // Hide the page controller and adjust collection view constraints
            pageView.view.isHidden = true
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }

        reloadCollectionView()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        viewModel.filteredGames = Array(viewModel.games.dropFirst(3))

        // Show the page controller and adjust collection view constraints
        pageView.view.isHidden = false

        // Remove the collection view and page view from their superviews
        collectionView.removeFromSuperview()
        pageView.view.removeFromSuperview()

        // Re-add the collection view and page view with updated constraints
        view.addSubview(collectionView)
        view.addSubview(pageView.view)

        layout()
        reloadCollectionView()
        
    }
}


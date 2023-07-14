//
//  HomeViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//
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
        collectionView.reloadOnMainThread()
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
        
        NSLayoutConstraint.activate([
            
            
            pageView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            collectionView.topAnchor.constraint(equalTo: pageView.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        return viewModel.games.count - 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath) as! GameCell
        cell.configure(games: viewModel.games[indexPath.item + 3])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.games[indexPath.item + 3]._id)
    }
}
// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.service.downloadSearchGames(searchTerm: searchText) { result in
            self.viewModel.games = result!
            self.reloadCollectionView()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.games = []
    }
}


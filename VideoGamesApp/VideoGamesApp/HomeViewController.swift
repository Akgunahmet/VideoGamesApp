//
//  HomeViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//
//
import UIKit
import LoadingView

protocol HomeViewControllerProtocol: AnyObject {
    func style()
    func layout()
    func reloadCollectionView()
    func navigateToDetailScreen(games: Games)
    func setupPageViewControllerIfNeeded()
    func showLoadingView()
    func hideLoadingView()
}

final class HomeViewController: UIViewController {
    
    var pageView: UIPageViewController!
    var collectionView: UICollectionView!
    let viewModel = HomeViewModel()
    
    var noResultsLabel: UILabel = {
        let label = UILabel()
          label.text = "Sonuç Bulunamadı"
          label.textAlignment = .center
          label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
          label.textColor = .gray
          label.translatesAutoresizingMaskIntoConstraints = false
          label.isHidden = true
          return label
      }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        //collectionView.accessibilityIdentifier = "collectionView"
    }
    
    func setupPageViewController() {
        pageView.dataSource = self
        
        let initialViewControllers = viewModel.games.prefix(3).enumerated().map { (index, game) in
            return createViewController(withImageURL: game.backgroundImage ?? "", index: index)
        }
        
        if let initialViewController = initialViewControllers.first {
            pageView.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
        pageView.dataSource = (initialViewControllers.count > 1) ? self : nil
    }
    
    public func createViewController(withImageURL imageURL: String, index: Int) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        
        let imageView = UIImageView(frame: viewController.view.bounds)
        imageView.clipsToBounds = true
//        if let imageURLString = viewModel.games[index].backgroundImage {
//            imageView.downloadImage(withURLString: imageURLString)
//        } else {
//            imageView.cancelDownloading()
//        }
        if let imageURLString = viewModel.games[index].backgroundImage, let imageURL = URL(string: imageURLString) {
            imageView.sd_setImage(with: imageURL)
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(imageView)
        imageView.pinToEdgesOf(view: viewController.view)
        viewController.view.tag = index
        return viewController
    }
    
}
// MARK: - Extension Helper Function
extension HomeViewController: HomeViewControllerProtocol , LoadingShowable{
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
        
    }
    
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
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false // title gizlenmesini engellemek için
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        setupConstraints()
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
            pageView.view.isHidden = false
            
            collectionView.removeFromSuperview()
            pageView.view.removeFromSuperview()
            
            view.addSubview(collectionView)
            view.addSubview(pageView.view)
            
            layout()
        } else {
            
            viewModel.filteredGames(searchText: searchText)
            pageView.view.isHidden = true
            collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        reloadCollectionView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        viewModel.filteredGames = Array(viewModel.games.dropFirst(3))
        pageView.view.isHidden = false
        collectionView.removeFromSuperview()
        pageView.view.removeFromSuperview()
        
        view.addSubview(collectionView)
        view.addSubview(pageView.view)
        
        layout()
        reloadCollectionView()
    }
}

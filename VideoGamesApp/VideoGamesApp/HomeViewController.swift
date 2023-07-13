//
//  HomeViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit
import VideoGamesAPI

final class HomeViewController: UIViewController, UISearchBarDelegate {

    private var pageView: UIPageViewController!
    private var collectionView: UICollectionView!

    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()

    private var stackview: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()

    }

    
    private func style() {

        view.backgroundColor = .systemGray5
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false // title gizlenmesini engellemek için
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    private func layout() {
        // UIPageViewController oluşturma
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

        addChild(pageView)
        view.addSubview(pageView.view)
        pageView.didMove(toParent: self)
        pageView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let navbarHeight = navigationController?.navigationBar.frame.size.height ?? 0.0

            let titleHeight = navigationController?.navigationBar.frame.size.height ?? 0.0
            let searchControllerHeight = navigationItem.searchController?.searchBar.frame.size.height ?? 0.0
            let totalNavbarHeight = navbarHeight + titleHeight + searchControllerHeight
        NSLayoutConstraint.activate([
            pageView.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            pageView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: totalNavbarHeight),
            pageView.view.bottomAnchor.constraint(equalTo: pageControl.topAnchor),

            collectionView.topAnchor.constraint(equalTo: pageControl.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        // UIPageViewController veri kaynağının atanması
        pageView.dataSource = self
        // İlk sayfanın ayarlanması
        let initialPage = 0
        let initialViewController = createViewController(withColor: .red, index: initialPage)
        initialViewController.view.tag = initialPage // Etiket (tag) atanması
        pageView.setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)

    }

    private func createViewController(withColor color: UIColor, index: Int) -> UIViewController {

        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        viewController.view.tag = index // Etiket (tag) atanması

        return viewController
    }

    private func getColor(forIndex index: Int) -> UIColor {
        switch index {
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .yellow
        default:
            return .white
        }
    }
}
// MARK: - UIPageViewController
extension HomeViewController: UIPageViewControllerDataSource{

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Önceki sayfanın alınması
        guard let currentIndex = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }

        let previousIndex = currentIndex - 1

        // En sol sayfadaysa dönülmez
        guard previousIndex >= 0 else {
            return nil
        }

        return createViewController(withColor: getColor(forIndex: previousIndex), index: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Sonraki sayfanın alınması
        guard let currentIndex = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }

        let nextIndex = currentIndex + 1
        // En sağ sayfadaysa dönülmez
        guard nextIndex < 3 else {
            return nil
        }

        return createViewController(withColor: getColor(forIndex: nextIndex), index: nextIndex)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        // Sayfa sayısının döndürülmesi (isteğe bağlı)
        return 3
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // Mevcut sayfanın indeksinin döndürülmesi (isteğe bağlı)
        return pageViewController.viewControllers?.first?.view.tag ?? 0
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath) as! GameCell

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

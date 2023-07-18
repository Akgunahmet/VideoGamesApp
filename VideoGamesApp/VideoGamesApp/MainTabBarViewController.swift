//
//  MainTabBarViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
}
extension MainTabBarViewController {
    private func setup() {
        viewControllers = [
            createViewController(rootViewConttoler: HomeViewController(), title: "Home", imageName: "house"),
            createViewController(rootViewConttoler: FavoritesViewController(), title: "Favorites", imageName: "star.fill"),
            
        ]
        tabBar.tintColor = .systemPink
    }
    
    private func createViewController(rootViewConttoler: UIViewController, title: String, imageName: String) -> UINavigationController {
        
        let appearance = UINavigationBarAppearance()
        let controller = UINavigationController(rootViewController: rootViewConttoler)
        
        rootViewConttoler.title = title
        appearance.configureWithDefaultBackground()
        // controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        
        return controller
    }
}

//
//  MockFavoritesViewController.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp

final class MockFavoritesViewController: FavoritesViewControllerProtocol {
    
    var isInvokedStyle = false
    var isInvokedStyleCount = 0
    
    func style() {
        isInvokedStyle = true
        isInvokedStyleCount += 1
    }
    
    var isInvokedLayout = false
    var isInvokedLayoutCount = 0
    
    func layout() {
        isInvokedLayout = true
        isInvokedLayoutCount += 1
    }
    
    var isInvokedreloadCollectionView = false
    var isInvokedreloadCollectionViewCount = 0
    
    func reloadCollectionView() {
        isInvokedreloadCollectionView = true
        isInvokedreloadCollectionViewCount += 1
    }
    
    func navigateToDetailScreen(games: VideoGamesApp.Games) {
        
    }
}

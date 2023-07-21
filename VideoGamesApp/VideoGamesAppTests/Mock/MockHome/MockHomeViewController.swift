//
//  MockHomeViewController.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp

// Replace with your app's module name

final class MockHomeViewController: HomeViewControllerProtocol {
    
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
//    var isInvokedStyle = false
//    var isInvokedStyleCount = 0
    
    func navigateToDetailScreen(games: VideoGamesApp.Games) {
        
//        isInvokedStyle = true
//        isInvokedStyleCount += 1
    }
    var isInvokedsetupPageViewControllerIfNeeded = false
    var isInvokedsetupPageViewControllerIfNeededCount = 0
    
    func setupPageViewControllerIfNeeded() {
        isInvokedsetupPageViewControllerIfNeeded = true
        isInvokedsetupPageViewControllerIfNeededCount += 1
    }
    
    var  isInvokedShowLoadingView = false
    var  isInvokedShowLoadingViewCount = 0
    
    func showLoadingView() {
        isInvokedShowLoadingView = true
        isInvokedShowLoadingViewCount += 1
    }
    
    var  isInvokedHideLoadingView = false
    var  isInvokedHideLoadingViewCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoadingView = true
        isInvokedHideLoadingViewCount += 1
    }
    
}

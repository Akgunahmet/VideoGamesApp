//
//  MockFavoritesViewModel.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp

final class MockFavoritesViewModel: FavoritesViewModelProtocol {
    
    var view: VideoGamesApp.FavoritesViewControllerProtocol?
    
    var isInvokedViewDidLoad = false
    var isInvokedViewDidLoadCount = 0
    
    func viewDidLoad() {
        isInvokedViewDidLoad = true
        isInvokedViewDidLoadCount += 1
    }
    
    var isInvokedGetDetails = false
    var invokedGetDetailCount = 0
    var invokedGetDetailParameters: (id: Int, Void)?
    
    func getDetail(id: Int) {
        isInvokedGetDetails = true
        invokedGetDetailCount += 1
        invokedGetDetailParameters = (id, ())
    }

    var isInvokedBadgeValue = false
    var invokedBadgeValueCount = 0
    
    func badgeValue() {
        isInvokedBadgeValue = true
        invokedBadgeValueCount += 1
    }
    
    var isInvokedFetchFavoriteGames = false
    var isInvokedFetchFavoriteGamesCount = 0
    
    func fetchFavoriteGames() {
        isInvokedFetchFavoriteGames = true
        isInvokedFetchFavoriteGamesCount += 1
    }
    
    var isInvokedDeleteAllFavoriteGames = false
    var isInvokedDeleteAllFavoriteGamesCount = 0
    
    func deleteAllFavoriteGames() {
        isInvokedDeleteAllFavoriteGames = true
        isInvokedDeleteAllFavoriteGamesCount += 1
    }
}

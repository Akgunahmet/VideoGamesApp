//
//  MockDetailsViewModel.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp

final class MockDetailsViewModel: DetailsViewModelProtocol {
    
    var view: VideoGamesApp.DetailsViewControllerProtocol?
   
    var isInvokedViewDidLoad = false
    var isInvokedViewDidLoadCount = 0
    
    func viewDidLoad() {
        isInvokedViewDidLoad = true
        isInvokedViewDidLoadCount += 1
    }
    
    var isInvokedCheckFavoriteStatus = false
    var isInvokedCheckFavoriteStatusCount = 0
    
    func checkFavoriteStatus() {
        isInvokedCheckFavoriteStatus = true
        isInvokedCheckFavoriteStatusCount += 1
    }
    
    var isInvokedSaveGameToFavorites = false
    var isInvokedSaveGameToFavoritesCount = 0
    
    func saveGameToFavorites() {
        isInvokedSaveGameToFavorites = true
        isInvokedSaveGameToFavoritesCount += 1
    }
    
    var isInvokedDeleteGameFromFavorites = false
    var isInvokedDeleteGameFromFavoritesCount = 0
    
    func deleteGameFromFavorites() {
        isInvokedDeleteGameFromFavorites = true
        isInvokedDeleteGameFromFavoritesCount += 1
    }

}

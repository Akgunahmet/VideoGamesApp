//
//  MockHomeViewModel.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp


final class MockHomeViewModel: HomeViewModelProtocol {
    
    var view: VideoGamesApp.HomeViewControllerProtocol?
    
    var isInvokedViewDidLoad = false
    var isInvokedViewDidLoadCount = 0
    
    func viewDidLoad() {
        isInvokedViewDidLoad = true
        isInvokedViewDidLoadCount += 1
    }
    
    var isInvokedGetGames = false
    var isInvokedGetGamesCount = 0
    
    func getGames() {
        isInvokedGetGames = true
        isInvokedGetGamesCount += 1
    }
    
    var isInvokedGetDetails = false
    var invokedGetDetailCount = 0
    var invokedGetDetailParameters: (id: Int, Void)?
    
    func getDetail(id: Int) {
        isInvokedGetDetails = true
        invokedGetDetailCount += 1
        invokedGetDetailParameters = (id, ())
    }
    
    var isInvokedFilteredGames = false
    var invokedFilteredGamesCount = 0
    var invokedfilteredGamesParameters: (searchText: String, Void)?
    
    func filteredGames(searchText: String) {
        isInvokedFilteredGames = true
        invokedFilteredGamesCount += 1
        invokedfilteredGamesParameters = (searchText, ())
    }
}

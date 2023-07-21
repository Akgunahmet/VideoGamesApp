//
//  MockDetailsViewController.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp

 final class MockDetailsViewController: DetailsViewControllerProtocol {

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
     
     var isInvokedConfigure = false
     var isInvokedConfigureCount = 0
     
    func configure() {
        isInvokedConfigure = true
        isInvokedConfigureCount += 1
    }
    
     var isInvokedSetupNavBarItem = false
     var iisInvokedSetupNavBarItemCount = 0
     
    func setupNavBarItem() {
        isInvokedSetupNavBarItem = true
        iisInvokedSetupNavBarItemCount += 1
    }
    
    var games: VideoGamesApp.Games
     init(games: VideoGamesApp.Games) {
            self.games = games
        }
}

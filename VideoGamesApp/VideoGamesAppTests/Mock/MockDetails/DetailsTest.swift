//
//  DetailsTest.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp
import XCTest

final class DetailsTests: XCTestCase {
    var viewModel: MockDetailsViewModel!
    var view: MockDetailsViewController!
    var games: VideoGamesApp.Games!

    func test_viewDidLoad_InvokesRequiredViewMoethods() {
        
//        view = .init(games: games) {
//               self.games = games
//           }
        viewModel = .init()
      
//        XCTAssertFalse(view.isInvokedConfigure)
//        XCTAssertEqual(view.isInvokedConfigureCount, 0)
//        XCTAssertFalse(view.isInvokedStyle)
//        XCTAssertEqual(view.isInvokedStyleCount, 0)
//        XCTAssertFalse(view.isInvokedLayout)
//        XCTAssertEqual(view.isInvokedLayoutCount, 0)
//        XCTAssertFalse(view.isInvokedSetupNavBarItem)
//        XCTAssertEqual(view.iisInvokedSetupNavBarItemCount, 0)
//
        
        XCTAssertFalse(viewModel.isInvokedCheckFavoriteStatus)
        XCTAssertFalse(viewModel.isInvokedViewDidLoad)
        XCTAssertFalse(viewModel.isInvokedSaveGameToFavorites)
        XCTAssertFalse(viewModel.isInvokedDeleteGameFromFavorites)

//        viewModel.viewDidLoad()
//        view.configure()
//        view.layout()
//        view.style()
//        view.setupNavBarItem()
//
        viewModel.checkFavoriteStatus()
        viewModel.saveGameToFavorites()
        viewModel.viewDidLoad()
        viewModel.deleteGameFromFavorites()
    
        
//        XCTAssertTrue(view.isInvokedConfigure)
//        XCTAssertEqual(view.isInvokedConfigureCount, 1)
//        XCTAssertTrue(view.isInvokedStyle)
//        XCTAssertEqual(view.isInvokedStyleCount, 1)
//        XCTAssertTrue(view.isInvokedLayout)
//        XCTAssertEqual(view.isInvokedLayoutCount, 1)
//        XCTAssertTrue(view.isInvokedSetupNavBarItem)
//        XCTAssertEqual(view.iisInvokedSetupNavBarItemCount, 1)
        
        XCTAssertTrue(viewModel.isInvokedCheckFavoriteStatus)
        XCTAssertEqual(viewModel.isInvokedCheckFavoriteStatusCount, 1)
        XCTAssertTrue(viewModel.isInvokedViewDidLoad)
        XCTAssertEqual(viewModel.isInvokedViewDidLoadCount, 1)
        XCTAssertTrue(viewModel.isInvokedSaveGameToFavorites)
        XCTAssertEqual(viewModel.isInvokedSaveGameToFavoritesCount, 1)
        XCTAssertTrue(viewModel.isInvokedDeleteGameFromFavorites)
        XCTAssertEqual(viewModel.isInvokedDeleteGameFromFavoritesCount, 1)
   
    }
}

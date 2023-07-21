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

    func test_viewDidLoad_InvokesRequiredViewMoethods() {

        viewModel = .init()
    
        XCTAssertFalse(viewModel.isInvokedCheckFavoriteStatus)
        XCTAssertFalse(viewModel.isInvokedViewDidLoad)
        XCTAssertFalse(viewModel.isInvokedSaveGameToFavorites)
        XCTAssertFalse(viewModel.isInvokedDeleteGameFromFavorites)

        viewModel.checkFavoriteStatus()
        viewModel.saveGameToFavorites()
        viewModel.viewDidLoad()
        viewModel.deleteGameFromFavorites()
    
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

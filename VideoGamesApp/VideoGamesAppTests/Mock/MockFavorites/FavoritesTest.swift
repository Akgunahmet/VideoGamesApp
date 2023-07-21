//
//  MockFavoritesTest.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp
import XCTest


final class FavoritesTests: XCTestCase {
    var viewModel: MockFavoritesViewModel!
    var view: MockFavoritesViewController!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        viewModel = .init()
        
    }
    
    override func tearDown() {
        view = nil
        viewModel = nil
        
    }
    func test_viewDidLoad_InvokesRequiredViewMoethods() {
        
        XCTAssertFalse(view.isInvokedreloadCollectionView)
        XCTAssertEqual(view.isInvokedreloadCollectionViewCount, 0)
        XCTAssertFalse(view.isInvokedStyle)
        XCTAssertEqual(view.isInvokedStyleCount, 0)
        XCTAssertFalse(view.isInvokedLayout)
        XCTAssertEqual(view.isInvokedLayoutCount, 0)
        
        XCTAssertFalse(viewModel.isInvokedGetDetails)
        XCTAssertFalse(viewModel.isInvokedBadgeValue)
        XCTAssertFalse(viewModel.isInvokedViewDidLoad)
        XCTAssertFalse(viewModel.isInvokedFetchFavoriteGames)
        XCTAssertFalse(viewModel.isInvokedDeleteAllFavoriteGames)
        XCTAssertFalse(viewModel.isInvokedViewDidLoad)
        
        viewModel.viewDidLoad()
        view.style()
        view.layout()
        view.reloadCollectionView()
        viewModel.badgeValue()
        viewModel.deleteAllFavoriteGames()
        viewModel.fetchFavoriteGames()
        
        XCTAssertTrue(view.isInvokedreloadCollectionView)
        XCTAssertEqual(view.isInvokedreloadCollectionViewCount, 1)
        XCTAssertTrue(view.isInvokedStyle)
        XCTAssertEqual(view.isInvokedStyleCount, 1)
        XCTAssertTrue(view.isInvokedLayout)
        XCTAssertEqual(view.isInvokedLayoutCount, 1)
        XCTAssertTrue(viewModel.isInvokedViewDidLoad)
        XCTAssertEqual(viewModel.isInvokedViewDidLoadCount, 1)
        XCTAssertTrue(viewModel.isInvokedBadgeValue)
        XCTAssertEqual(viewModel.invokedBadgeValueCount, 1)
        XCTAssertEqual(viewModel.isInvokedDeleteAllFavoriteGamesCount, 1)
        XCTAssertEqual(viewModel.isInvokedFetchFavoriteGamesCount, 1)
        
    }
}

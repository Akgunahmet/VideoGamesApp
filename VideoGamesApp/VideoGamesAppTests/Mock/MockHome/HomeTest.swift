//
//  MockHomeViewModel.swift
//  VideoGamesAppTests
//
//  Created by Ahmet Akgün on 21.07.2023.
//

import Foundation
@testable import VideoGamesApp
import XCTest

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: MockHomeViewModel!
    var view: MockHomeViewController!
    
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
        XCTAssertFalse(view.isInvokedHideLoadingView)
        XCTAssertEqual(view.isInvokedHideLoadingViewCount, 0)
        XCTAssertFalse(view.isInvokedShowLoadingView)
        XCTAssertEqual(view.isInvokedShowLoadingViewCount, 0)
        XCTAssertFalse(view.isInvokedsetupPageViewControllerIfNeeded)
        XCTAssertEqual(view.isInvokedsetupPageViewControllerIfNeededCount, 0)
        
        XCTAssertFalse(viewModel.isInvokedGetGames)
        XCTAssertFalse(viewModel.isInvokedViewDidLoad)
        XCTAssertFalse(viewModel.isInvokedFilteredGames)
        XCTAssertFalse(viewModel.isInvokedGetDetails)
        
        view.style()
        view.layout()
        view.hideLoadingView()
        view.showLoadingView()
        view.setupPageViewControllerIfNeeded()
        view.reloadCollectionView()
        
        XCTAssertTrue(view.isInvokedreloadCollectionView)
        XCTAssertEqual(view.isInvokedreloadCollectionViewCount, 1)
        XCTAssertTrue(view.isInvokedStyle)
        XCTAssertEqual(view.isInvokedStyleCount, 1)
        XCTAssertTrue(view.isInvokedLayout)
        XCTAssertEqual(view.isInvokedLayoutCount, 1)
        XCTAssertTrue(view.isInvokedHideLoadingView)
        XCTAssertEqual(view.isInvokedHideLoadingViewCount, 1)
        XCTAssertTrue(view.isInvokedShowLoadingView)
        XCTAssertEqual(view.isInvokedShowLoadingViewCount, 1)
        XCTAssertTrue(view.isInvokedsetupPageViewControllerIfNeeded)
        XCTAssertEqual(view.isInvokedsetupPageViewControllerIfNeededCount, 1)
        
    }
}

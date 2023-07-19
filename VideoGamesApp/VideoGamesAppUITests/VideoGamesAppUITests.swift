//
//  VideoGamesAppUITests.swift
//  VideoGamesAppUITests
//
//  Created by Ahmet Akgün on 13.07.2023.
//


import XCTest

final class VideoGamesAppUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    private var app: XCUIApplication!


    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("******** UITest ********")
    }
//    override func setUp() {
//        super.setUp()
//        continueAfterFailure = false
//
//        app = XCUIApplication()
//        app.launchArguments.append("******** UITest ********")
//    }

//    func testSearchBarAndTableView() {
//
//        app.launch()
//
//       // XCTAssertTrue(app.isSearchBarDisplayed)
//        XCTAssertTrue(app.isCollectionViewDisplayed)
//
//        app.searchBar.tap()
//      //  app.searchBar.typeText("Tarkan")
//     //   app.keyboards.buttons["Search"].tap()
//
//        let collectionCells = app.collectionView.cells.element(boundBy: 1)
//        sleep(3)
//        collectionCells.tap()
//        sleep(5)
//
//
//        XCTAssertTrue(app.isFavoriteButtonDisplayed)
//
////        app.detailPlayButton.tap()
////        sleep(5)
////        app.detailPlayButton.tap()
////        sleep(2)
//        app.detailFavoriteButton.tap()
//        sleep(1)
//    }
    
    func test() {
        
        let app = XCUIApplication()
        app.launch()
        let homeNavigationBar = app.navigationBars["Home"]
        sleep(2)
        let searchSearchField = homeNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        sleep(2)
        let collectionviewCollectionView = app.collectionViews["collectionView"]
        collectionviewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Rating: 3.6"]/*[[".cells.staticTexts[\"Rating: 3.6\"]",".staticTexts[\"Rating: 3.6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        let loveButton = homeNavigationBar.buttons["love"]
        loveButton.tap()
        sleep(2)
        let homeButton = homeNavigationBar.buttons["Home"]
        homeButton.tap()
        searchSearchField.tap()
        sleep(2)
        homeNavigationBar.buttons["Cancel"].tap()
        collectionviewCollectionView.cells.otherElements.containing(.staticText, identifier:"Portal").element.tap()
        sleep(2)
        loveButton.tap()
        homeButton.tap()
        sleep(2)
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Portal"]/*[[".cells.staticTexts[\"Portal\"]",".staticTexts[\"Portal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        let favoritesNavigationBar = app.navigationBars["Favorites"]
        favoritesNavigationBar.buttons["love"].tap()
        favoritesNavigationBar.buttons["Favorites"].tap()
        favoritesNavigationBar.buttons["trash"].tap()
                
                
//
//        let app = XCUIApplication()
//        app.launch()
//        let homeNavigationBar = app.navigationBars["Home"]
//        homeNavigationBar.searchFields["Search"].tap()
//
//        let cKey = app/*@START_MENU_TOKEN@*/.keys["C"]/*[[".keyboards.keys[\"C\"]",".keys[\"C\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        cKey.tap()
//
//
//        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        oKey.tap()
//
//
//        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        uKey.tap()
//
//
//        let collectionviewCollectionView = app.collectionViews["collectionView"]
//        collectionviewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Rating: 3.6"]/*[[".cells.staticTexts[\"Rating: 3.6\"]",".staticTexts[\"Rating: 3.6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        homeNavigationBar.buttons["love"].tap()
//
//        let homeButton = homeNavigationBar.buttons["Home"]
//        homeButton.tap()
//        homeNavigationBar.buttons["Cancel"].tap()
//        collectionviewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Rating: 4.5"]/*[[".cells.staticTexts[\"Rating: 4.5\"]",".staticTexts[\"Rating: 4.5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        homeButton.tap()
//
//        let tabBar = app.tabBars["Tab Bar"]
//        tabBar.buttons["Favorites"].tap()
//        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Counter-Strike: Global Offensive").element.tap()
//
//        let favoritesNavigationBar = app.navigationBars["Favorites"]
//        favoritesNavigationBar.buttons["Favorites"].tap()
//        favoritesNavigationBar.buttons["trash"].tap()
//        tabBar.buttons["Home"].tap()
                
    }

}

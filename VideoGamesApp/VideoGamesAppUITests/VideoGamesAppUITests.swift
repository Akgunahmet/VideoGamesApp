//
//  VideoGamesAppUITests.swift
//  VideoGamesAppUITests
//
//  Created by Ahmet Akgün on 13.07.2023.
//


import XCTest

final class VideoGamesAppUITests: XCTestCase {
  
    private var app: XCUIApplication!


    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("******** UITest ********")
    }

    func test() {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Tomb Raider (2013)").element.tap()
        
        let homeNavigationBar = app.navigationBars["Home"]
        homeNavigationBar.buttons["love"].tap()
        
        let homeButton = homeNavigationBar.buttons["Home"]
        homeButton.tap()
        
        let searchSearchField = homeNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["C"]/*[[".keyboards.keys[\"C\"]",".keys[\"C\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uKey.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rating: 3.6"]/*[[".cells.staticTexts[\"Rating: 3.6\"]",".staticTexts[\"Rating: 3.6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        homeButton.tap()
        searchSearchField.buttons["Clear text"].tap()
        homeNavigationBar.buttons["Cancel"].tap()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rating: 4.0"]/*[[".cells.staticTexts[\"Rating: 4.0\"]",".staticTexts[\"Rating: 4.0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let favoritesNavigationBar = app.navigationBars["Favorites"]
        favoritesNavigationBar.buttons["love"].tap()
        app.alerts["Delete from Favorites"].scrollViews.otherElements.buttons["Delete"].tap()
        favoritesNavigationBar.buttons["Favorites"].tap()
            
        
//
//        let app = XCUIApplication()
//        app.launch()
//        let collectionViewsQuery = app.collectionViews
//        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rating: 4.0"]/*[[".cells.staticTexts[\"Rating: 4.0\"]",".staticTexts[\"Rating: 4.0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let homeNavigationBar = app.navigationBars["Home"]
//        let loveButton = homeNavigationBar.buttons["love"]
//        loveButton.tap()
//        loveButton.tap()
//        app.alerts["Delete from Favorites"].scrollViews.otherElements.buttons["Delete"].tap()
//
//        let homeButton = homeNavigationBar.buttons["Home"]
//        homeButton.tap()
//
//        let searchSearchField = homeNavigationBar.searchFields["Search"]
//        searchSearchField.tap()
//        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rating: 3.6"]/*[[".cells.staticTexts[\"Rating: 3.6\"]",".staticTexts[\"Rating: 3.6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        homeButton.tap()
//        searchSearchField.tap()
//        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
//        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Released Date: 2012-08-21"]/*[[".cells.staticTexts[\"Released Date: 2012-08-21\"]",".staticTexts[\"Released Date: 2012-08-21\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let favoritesNavigationBar = app.navigationBars["Favorites"]
//        favoritesNavigationBar.buttons["Favorites"].tap()
//        favoritesNavigationBar.buttons["trash"].tap()
//        app.alerts["Delete All Favorites"].scrollViews.otherElements.buttons["Delete"].tap()
                        
                
    }

}

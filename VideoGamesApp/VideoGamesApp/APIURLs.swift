//
//  APIURLs.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//


import Foundation

enum APIURLs {
    static func games() -> String {
        "https://api.rawg.io/api/games?key=5a8a1ff03cfa4515b0647f1a85deb418"
    }
//    static func imageURL(backgroundImage: String) -> String {
//        "\(backgroundImage)"
//    }
//
    static func detail(id: Int) -> String {
        "https://api.rawg.io/api/games/\(id)?key=5a8a1ff03cfa4515b0647f1a85deb418"
    }
}


//
//  VideoGames.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import Foundation

// MARK: - VideoGame
public struct VideoGames: Codable {
    public let count: Int?
    public let next: String?
    public let results: [Games]?
    public let description: String?
    //public let filters: Filters?
    
}

// MARK: - Result
public struct Games: Codable {
public  let id: Int?
public  let name, released: String?
public  let backgroundImage: String?
public  let rating: Double?
public  let ratingTop: Int?
public  let metacritic: Int?
    public let description: String?

    enum CodingKeys: String, CodingKey {
        case name, released, description
        case id
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case metacritic
    
    }
    var _id: Int {
        id ?? Int.min
    }
    
    var _backgroundImage: String {
        backgroundImage ?? ""
    }
    
    var _name: String {
        name ?? "N/A"
    }
    
    var _release: String {
        released ?? "N/A"
    }
    
    var _rating: Double {
        rating ?? 0.0
    }
    var _description: String {
        description ?? "N/A"
    }
    var _metacritic: Int {
        metacritic ?? 0
    }
}


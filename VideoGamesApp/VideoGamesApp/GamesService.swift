//
//  GamesService.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import Foundation

final class GamesService {
    
   func downloadGames(page: Int, completion: @escaping ([Games]?) -> ()) {
        guard let url = URL(string: APIURLs.games(page: page)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
   func downloadDetail(id: Int, completion: @escaping (Games?) -> ()) {
        guard let url = URL(string: APIURLs.detail(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handleWithData(_ data: Data) -> [Games]? {
        do {
            let game = try JSONDecoder().decode(VideoGames.self, from: data)
            return game.results
        } catch {
            print(error)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> Games? {
        do {
            let gameDetail = try JSONDecoder().decode(Games.self, from: data)
            return gameDetail
        } catch {
            print(error)
            return nil
        }
    }
}


//
//  HomeViewModel.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import Foundation


protocol HomeViewModelProtocol {
    var view: HomeViewControllerProtocol? { get set }
    func viewDidLoad()
   func getGames()
}
final class HomeViewModel {
     weak var view: HomeViewControllerProtocol?
     public let service = GamesService()
    var games: [Games] = []

    
     private var page: Int = 1
}

extension HomeViewModel: HomeViewModelProtocol {
    
        func viewDidLoad() {
            view?.style()
            view?.layout()
            getGames()
            
        }
        
    func getGames() {
//        shouldDownloadMore = false
        service.downloadGames(page: page) { [weak self] returnedGames in
            guard let self = self else { return }
            guard let returnedGames = returnedGames else { return }

            self.games.append(contentsOf: returnedGames)

            self.page += 1

            self.view?.reloadCollectionView()
            self.view?.setupPageViewControllerIfNeeded()
//            self.shouldDownloadMore = true
        }
    }




    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            
            self.view?.navigateToDetailScreen(games: returnedDetail)
        }
    }
}

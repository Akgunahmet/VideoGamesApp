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
    var filteredGames: [Games] = []
    private var page: Int = 1
    
}
extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
        getGames()
    }
    
    func getGames() {
        view?.showLoadingView()
        service.downloadGames(page: page) { [weak self] returnedMovies in
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else { return }
            
            self.games.append(contentsOf: returnedMovies)
            self.filteredGames = Array(self.games.dropFirst(3))
            
            self.page += 1
          
            self.view?.reloadCollectionView()
            self.view?.setupPageViewControllerIfNeeded()
            view?.hideLoadingView()
        }
    }
    
    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            
            self.view?.navigateToDetailScreen(games: returnedDetail)
        }
    }
    
    func filteredGames(searchText: String) {
        filteredGames = games.filter { game in
            if let gameTitle = game.name {
                return gameTitle.lowercased().contains(searchText.lowercased())
            }
            return false
        }
    }
}

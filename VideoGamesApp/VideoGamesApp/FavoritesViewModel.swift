//
//  FavoritesViewModel.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import UIKit
import CoreData

protocol FavoritesViewModelProtocol {
    var view: FavoritesViewControllerProtocol? { get set }
    func viewDidLoad()


}

final class FavoritesViewModel {
     weak var view: FavoritesViewControllerProtocol?
     var resultCoreDataItems: [GamesCoreData] = []
    public let service = GamesService()
   var games: [Games] = []

}
extension FavoritesViewModel: FavoritesViewModelProtocol {

    
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
        fetchFavoriteGames()
        
    }
    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            
            self.view?.navigateToDetailScreen(games: returnedDetail)
        }
    }

     func fetchFavoriteGames() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
        
        do {
            resultCoreDataItems = try managedContext.fetch(fetchRequest)
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadCollectionView() // Notify the view controller to reload the collection view on the main thread
            }
        } catch let error as NSError {
            print("Could not fetch favorite games from Core Data. Error: \(error), \(error.userInfo)")
        }
    }
    func deleteAllFavoriteGames() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GamesCoreData")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(batchDeleteRequest)
            resultCoreDataItems.removeAll() // Veri dizisini temizle
            view?.reloadCollectionView() // Collection view'i yeniden yükle
            
        } catch let error as NSError {
            print("Could not delete favorite games from Core Data. Error: \(error), \(error.userInfo)")
        }
    }

}

//
//  DetailsViewModel.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//


import CoreData
import UIKit

protocol DetailsViewModelProtocol {
    var view: DetailsViewControllerProtocol? { get set }
    func viewDidLoad()
}


final class DetailsViewModel {
    weak var view: DetailsViewControllerProtocol?
    private var resultCoreDataItems: [GamesCoreData] = []
    
    var isFavorite = false
    
}

extension DetailsViewModel: DetailsViewModelProtocol {
    func viewDidLoad() {
        view?.style()
        view?.layout()
        view?.configure()
    }

    
    func checkFavoriteStatus() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", view?.games._name ?? "")
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            isFavorite = !favorites.isEmpty
        } catch let error as NSError {
            print("Could not fetch favorite games. Error: \(error), \(error.userInfo)")
        }
    }
    
    func saveGameToFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let favoriteGame = GamesCoreData(context: managedContext)
        favoriteGame.name = view?.games._name
        favoriteGame.rating = view?.games._rating ?? 0
        favoriteGame.id = Int16(view?.games._id ?? 0)
        favoriteGame.backgroundImage = view?.games.backgroundImage
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarViewController
        mainTabController.viewControllers?[1].tabBarItem.badgeValue = "New"

        do {
            try managedContext.save()
            isFavorite = true
            view?.setupNavBarItem()
            print("başarılı kaydedildi")
        } catch let error as NSError {
            print("Could not save game to favorites. Error: \(error), \(error.userInfo)")
        }
    }
    func deleteGameFromFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", view?.games._name ?? "")
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            if let favoriteGame = favorites.first {
                managedContext.delete(favoriteGame)
                try managedContext.save()
                isFavorite = false
                view?.setupNavBarItem()
                print("başarılı silindi")
            }
        } catch let error as NSError {
            print("Could not delete game from favorites. Error: \(error), \(error.userInfo)")
        }
    }
    
}

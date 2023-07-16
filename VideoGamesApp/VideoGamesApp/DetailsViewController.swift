//
//  DetailsViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//
import UIKit
import CoreData

protocol DetailsViewControllerProtocol: AnyObject {
    func style()
    func layout()
    func configure()

}

final class DetailsViewController: UIViewController {
    
    private let games: Games
    private let viewModel = DetailsViewModel()
    private let favoriteViewModel = FavoritesViewModel()
    init(games: Games) {
        self.games = games
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameImageView: PosterImageView = {
        let imageView = PosterImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of Game"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let gameDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    private let gameRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Metacritic Rate"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description Description Description "
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var isFavorite = false
    
    private var resultCoreDataItems: [GamesCoreData] = []
    
    var labelStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        checkFavoriteStatus()
        setupNavBarItem()
    }

}
extension DetailsViewController {


    private func setupNavBarItem() {
        let buttonImage = isFavorite ? UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal) : UIImage(systemName: "heart")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        let navRightItem = UIBarButtonItem(image: buttonImage, style: .done, target: self, action: #selector(handleFavoriButton))
        self.navigationItem.rightBarButtonItem = navRightItem
    }

    private func checkFavoriteStatus() {
        // Fetch the favorite game with a matching name
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", games._name)
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            isFavorite = !favorites.isEmpty
        } catch let error as NSError {
            print("Could not fetch favorite games. Error: \(error), \(error.userInfo)")
        }
    }

    private func saveGameToFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new Favorites entity object
        let favoriteGame = GamesCoreData(context: managedContext)
        favoriteGame.name = games._name
        favoriteGame.rating = games._rating
        favoriteGame.id = Int16(games._id)
//        favoriteGame.release = games._release
        favoriteGame.backgroundImage = games.backgroundImage
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarViewController
        mainTabController.viewControllers?[1].tabBarItem.badgeValue = "New"
        // Save the context
        do {
            try managedContext.save()
            isFavorite = true
            setupNavBarItem()
            print("başarılı kaydedildi")
        } catch let error as NSError {
            print("Could not save game to favorites. Error: \(error), \(error.userInfo)")
        }
    }
    private func deleteGameFromFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Fetch the favorite game with a matching name
        let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", games._name)
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            if let favoriteGame = favorites.first {
                managedContext.delete(favoriteGame)
                try managedContext.save()
                isFavorite = false
                setupNavBarItem() 
                print("başarılı silindi")
            }
        } catch let error as NSError {
            print("Could not delete game from favorites. Error: \(error), \(error.userInfo)")
        }
    }
    @objc private func handleFavoriButton() {
        if isFavorite {
            deleteGameFromFavorites()
            isFavorite = false
        } else {
            saveGameToFavorites()
            isFavorite = true
        }
        setupNavBarItem()
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {

    func configure() {
        gameNameLabel.text = games._name
        gameRateLabel.text = String(format: "%.1f", games._rating)
        gameDateLabel.text = games._release
        gameImageView.downloadImage(game: games)
        let cleanedDescription = games._description.stripHTMLTags()
        gameDescriptionLabel.text = cleanedDescription
    }
    
     func style() {
        view.backgroundColor = .systemBackground
        labelStackView = UIStackView(arrangedSubviews: [gameNameLabel,
                                                       gameDateLabel,
                                                       gameRateLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
     func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gameImageView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(gameDescriptionLabel)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            gameImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            labelStackView.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 8),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            gameDescriptionLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 8),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

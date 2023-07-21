//
//  DetailsViewController.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//
import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func style()
    func layout()
    func configure()
    func setupNavBarItem()
    var games: Games { get }
}

final class DetailsViewController: UIViewController {
    let games: Games
    
    private let viewModel = DetailsViewModel()
    
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
        imageView.clipsToBounds = true
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
    
    
    var labelStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkFavoriteStatus()
        setupNavBarItem()
    }
}

extension DetailsViewController {
    
    func setupNavBarItem() {
        let buttonImage = viewModel.isFavorite ? UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal) : UIImage(systemName: "heart")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        let navRightItem = UIBarButtonItem(image: buttonImage, style: .done, target: self, action: #selector(handleFavoriButton))
        self.navigationItem.rightBarButtonItem = navRightItem
    }
    
    
    @objc private func handleFavoriButton() {
        if viewModel.isFavorite {
//            viewModel.deleteGameFromFavorites()
//            viewModel.isFavorite = false
            confirmDeleteAlert()
        } else {
            viewModel.saveGameToFavorites()
            viewModel.isFavorite = true
        }
        setupNavBarItem()
    }
    private func confirmDeleteAlert() {
        let alertController = UIAlertController(title: "Delete from Favorites", message: "Are you sure you want to remove this game from your favorites?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel.deleteGameFromFavorites()
            self.viewModel.isFavorite = false
            self.setupNavBarItem()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        present(alertController, animated: true, completion: nil)
    }

}

extension DetailsViewController: DetailsViewControllerProtocol {
    
    func configure() {
        gameNameLabel.text = games._name
        //gameRateLabel.text = String(format: "%.1f", games._rating)
//        if let metacritic = games.metacritic {
//            gameRateLabel.text = String(metacritic)
//        } else {
//            gameRateLabel.text = "N/A"
//        }
        gameRateLabel.text = "\(games._metacritic)"
        gameDateLabel.text = games._release
      //  gameImageView.downloadImage(game: games)
        if let imageURLString = games.backgroundImage {
                gameImageView.downloadImage(withURLString: imageURLString)
            } else {
                gameImageView.cancelDownloading()
            }

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

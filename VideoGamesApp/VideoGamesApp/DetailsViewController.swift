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
}

final class DetailsViewController: UIViewController {
    
    private let games: Games
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
        imageView.backgroundColor = .systemTeal
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
    
    var labelStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    
    }
}

extension String {
    func stripHTMLTags() -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
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
            
            //gameDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            gameDescriptionLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 8),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

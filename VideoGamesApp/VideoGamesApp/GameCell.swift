//
//  GameCell.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit


final class GameCell: UICollectionViewCell {
    static let reuseID = "GameCell"
    
    private var photoImageView: PosterImageView = {
        let imageView = PosterImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gameName: UILabel = {
       let label = UILabel()
        label.text = "Name of Game"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let ratingLabel: UILabel = {
       let label = UILabel()
        label.text = "Raiting"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
 
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        photoImageView.cancelDownloading()
    }
}
extension GameCell {
    private func setup(){
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 12

        stackView = UIStackView(arrangedSubviews: [gameName,ratingLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
//        photoImageView = PosterImageView(frame: .zero)
        addSubview(photoImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            stackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }


    func configure(games: Games) {
        photoImageView.downloadImage(game: games)
        gameName.text = games.name
        ratingLabel.text = String(format: "%.1f", games.rating ?? "")
    }
}

//
//  GameCell.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 13.07.2023.
//

import UIKit
import VideoGamesAPI

final class GameCell: UICollectionViewCell {
    static let reuseID = "GameCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
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
    func artworkUrl(for game: Games) -> URL? {
        if let artworkUrlString = game.backgroundImage, let artworkUrl = URL(string: artworkUrlString) {
            return artworkUrl
        }
        return nil
    }

     func configure(games: Games) {
        gameName.text = games.name
        ratingLabel.text = String(format: "%.1f", games.rating ?? "")
         
//         if let backgroundImageURLString = games.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString) {
//             URLSession.shared.dataTask(with: backgroundImageURL) { (data, response, error) in
//                 if let error = error {
//                     print("Error: \(error.localizedDescription)")
//                     return
//                 }
//
//                 if let data = data, let backgroundImage = UIImage(data: data) {
//                     DispatchQueue.main.async {
//                         self.photoImageView.image = backgroundImage
//                     }
//                 }
//             }.resume()
//         }
         if let artworkUrl = artworkUrl(for: games) {
             URLSession.shared.dataTask(with: artworkUrl) { (data, response, error) in
                 if let data = data {
                     DispatchQueue.main.async {
                         self.photoImageView.image = UIImage(data: data)
                     }
                 }
             }.resume()
         }
     }
}

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
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.text = "Released Date"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let seperatorLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var labelStackView: UIStackView!
    private var mainStackView: UIStackView!
    
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
//        labelStackView = UIStackView(arrangedSubviews: [ratingLabel,
//                                                        seperatorLabel,
//                                                       releasedLabel,
//                                                        UIView()])
//        labelStackView.axis = .horizontal
//        labelStackView.spacing = 5
//        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView = UIStackView(arrangedSubviews: [gameName,
                                                       ratingLabel,
                                                      releasedLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        addSubview(photoImageView)
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            mainStackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 6),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(games: Games) {

        if let imageURLString = games.backgroundImage {
                photoImageView.downloadImage(withURLString: imageURLString)
            } else {
                photoImageView.cancelDownloading()
            }
        gameName.text = games.name
        ratingLabel.text = "Rating: " + String(format: "%.1f", games.rating ?? 0.0)

        releasedLabel.text = "Released Date: \(games._release)"
    }
}

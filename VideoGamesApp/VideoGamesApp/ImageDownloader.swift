//
//  ImageDownloader.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//


import UIKit

public class PosterImageView: UIImageView{
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(game: Games) {
        
        guard let url = URL(string: APIURLs.imageURL(backgroundImage: game._backgroundImage)) else { return }
        
        dataTask = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            case .failure(_):
                break
            }
        }
    }
    func downloadImage(game: GamesCoreData) {
        guard let urlString = game.backgroundImage, let url = URL(string: urlString) else { return }
        
        dataTask = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            case .failure(_):
                break
            }
        }
    }
    
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
}


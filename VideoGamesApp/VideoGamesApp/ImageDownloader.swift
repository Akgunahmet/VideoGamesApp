//
//  ImageDownloader.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//
//import UIKit
//
//public class PosterImageView: UIImageView {
//    
//    private var imageURLString: String?
//    private var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func downloadImage(withURLString urlString: String) {
//        imageURLString = urlString
//        
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            image = cachedImage
//            return
//        }
//        
//        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let self = self,
//                  let data = data,
//                  let downloadedImage = UIImage(data: data) else {
//                return
//            }
//            
//            self.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
//            
//            DispatchQueue.main.async {
//                if self.imageURLString == urlString {
//                    self.image = downloadedImage
//                }
//            }
//        }
//        
//        dataTask.resume()
//    }
//    
//    func cancelDownloading() {
//        image = nil
//        imageURLString = nil
//    }
//}
//
//

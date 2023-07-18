//
//  LoadingView.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 18.07.2023.
//


import UIKit

class LoadingView {
    // MARK: Properties
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    private init() {
        configure()
    }
    // MARK: Function
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let mainWindow = windowScene.windows.first {
                mainWindow.addSubview(blurView)
                blurView.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.startAnimating()
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
              self?.blurView.removeFromSuperview()
            self?.activityIndicator.stopAnimating()
          }
       // activityIndicator.stopAnimating()
        
    }
}


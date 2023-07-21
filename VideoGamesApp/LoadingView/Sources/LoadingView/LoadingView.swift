//
//  File 2.swift
//  
//
//  Created by Ahmet Akgün on 20.07.2023.
//


import UIKit

class LoadingView {
    // MARK: Properties
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    static let shared = LoadingView()
    
    private init() {
        configure()
    }
    
    // MARK: Function
    public func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        blurView.contentView.addSubview(activityIndicator)
    }
    
    @available(iOS 13.0, *)
    public func startLoading() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let mainWindow = windowScene.windows.first {
                mainWindow.addSubview(blurView)
                blurView.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.startAnimating()
            }
        }
    }
    
    public func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.blurView.removeFromSuperview()
            self?.activityIndicator.stopAnimating()
        }
    }
}



//
//  File.swift
//  
//
//  Created by Ahmet Akgün on 20.07.2023.
//

import UIKit

public protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

@available(iOS 13.0, *)
extension LoadingShowable {
   public func showLoading() {
        LoadingView.shared.startLoading()
    }

   public func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}

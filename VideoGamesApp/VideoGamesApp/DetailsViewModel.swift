//
//  DetailsViewModel.swift
//  VideoGamesApp
//
//  Created by Ahmet Akgün on 14.07.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    var view: DetailsViewControllerProtocol? { get set }
    
    func viewDidLoad()
}

final class DetailsViewModel {
    weak var view: DetailsViewControllerProtocol?
}

extension DetailsViewModel: DetailsViewModelProtocol {
    func viewDidLoad() {
        view?.style()
        view?.layout()
        view?.configure()

    }
    
}

//
//  HomeRouter.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation

class HomeRouter: Router {
    
    // MARK: - Typealias
    
    typealias PresenterType = HomePresenter
    
    // MARK: - Properties
    
    weak var presenter: HomePresenter?
    
    // MARK: - Init and deinit
    
    required init(presenter: HomePresenter) {
        self.presenter = presenter
    }
}

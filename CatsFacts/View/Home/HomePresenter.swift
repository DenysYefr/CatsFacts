//
//  HomePresenter.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

class HomePresenter: Presenter {
    
    // MARK: - Typealias
    
    typealias ViewType = HomeView
    typealias InteractorType = HomeInteractor
    typealias RouterType = HomeRouter
    
    // MARK: - Properties
    
    weak var view: HomeView?
    var interactor: InteractorType?
    var router: RouterType?
    
    // MARK: - Init and deinit
        
    required init(view: HomeView) {
        self.view = view
        self.interactor = HomeInteractor(presenter: self)
        self.router = HomeRouter(presenter: self)
    }
    
    // MARK: - Public
    
    public func presentFacts() {
        guard let navigation = view?.navigationController else { fatalError("FactsView must have navigation controller!") }
        router?.pushNavigation(with: navigation, storyboardId: "factsView", animated: true)
    }
}
